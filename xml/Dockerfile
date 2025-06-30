FROM alpine:3.22.0@sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715

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
    curl=8.14.1-r1 \
    git=2.49.0-r0 \
    html-xml-utils=8.7-r0 \
    libxml2-utils=2.13.8-r0 \
    libxslt=1.1.43-r3 \
    maven=3.9.9-r0 \
    openjdk21-jre-headless=21.0.7_p6-r0 \
    py3-pip=25.1.1-r0 \
    python3=3.12.11-r0 \
    xmlindent=0.2.17-r3 \
    xmlsec=1.3.7-r0 \
    xmlstarlet=1.6.1-r2 \
    xmlto=0.0.29-r0 \
    && if apk -u list | grep -q -e . ; then \
      apk -u list ; \
      exit 1 ; \
    fi \
    && apk cache clean \
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

USER "${USER_NAME}"

ENV HOME="${USER_HOME}"

WORKDIR "${HOME}"
