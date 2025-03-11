FROM alpine:3.21.3@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c

HEALTHCHECK NONE

ARG USER_NAME=default
ARG USER_HOME=/home/default
ARG USER_ID=1000
ARG USER_GECOS=Default

# @TL FIXME: xml2rfc currently only in edge stream
# hadolint ignore=DL3018
RUN apk --update --no-cache add \
    html-xml-utils \
    libxml2-utils \
    libxslt \
    maven \
    openjdk21-jre-headless \
    py3-pip \
    python3 \
    python3-dev \
    xmlindent \
    xmlsec \
    xmlstarlet \
    xmlto \
    && rm -rf /var/cache/apk/*

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN pip3 install --no-cache-dir --upgrade --break-system-packages \
    gpxpy==1.6.2 \
    tcx2gpx==0.1.5 \
    yq==3.4.3 \
    && msg="$(pip list --outdated | grep -e -e gpxpy -e tcx2gpx -e yq || true)" \
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
