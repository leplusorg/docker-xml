FROM alpine:3.21.3@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c

HEALTHCHECK NONE

ARG USER_NAME=default
ARG USER_HOME=/home/default
ARG USER_ID=1000
ARG USER_GECOS=Default

SHELL ["/bin/ash", "-euo", "pipefail", "-c"]

# @TL FIXME: xml2rfc currently only in edge stream
# hadolint ignore=DL3019
RUN apk -U upgrade \
    && apk add \
    html-xml-utils=8.6-r0 \
    libxml2-utils=2.13.4-r5 \
    libxslt=1.1.42-r1 \
    maven=3.9.9-r0 \
    openjdk21-jre-headless=21.0.6_p7-r0 \
    py3-pip=24.3.1-r0 \
    python3=3.12.9-r0 \
    xmlindent=0.2.17-r3 \
    xmlsec=1.3.7-r0 \
    xmlstarlet=1.6.1-r2 \
    xmlto=0.0.29-r0 \
    && if apk -u list | grep -q -e . ; then \
      apk -u list ; \
      exit 1 ; \
    fi \
    && rm -rf /var/cache/apk/*

RUN pip3 install --no-cache-dir --upgrade --break-system-packages \
    gpxpy==1.6.2 \
    tcx2gpx==0.1.5 \
    yq==3.4.3 \
    && msg="$(pip3 list --outdated | grep -i -e '^gpxpy ' -e '^tcx2gpx ' -e '^yq ' || true)" \
    && if [ -n "${msg}" ]; then \
       >&2 echo "ERROR: outdated: ${msg}" ; \
       exit 1 ; \
    fi

RUN mkdir -p /opt/saxon

COPY pom.xml mvnw run.sh /opt/saxon/

COPY .mvn/ /opt/saxon/.mvn/

WORKDIR /opt/saxon

RUN ./mvnw dependency:copy-dependencies && chmod -R o+rX /opt/saxon

RUN adduser \
  --home "${USER_HOME}" \
  --uid "${USER_ID}" \
  --gecos "${USER_GECOS}" \
  --disabled-password \
  "${USER_NAME}"

ENV HOME="${USER_HOME}"

USER "${USER_NAME}"

WORKDIR "${HOME}"
