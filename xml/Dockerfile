FROM eclipse-temurin:22_36-jdk-alpine@sha256:515c8651927ffe6f7a5db63ac39446946246a0293a11f3d5ea24dbffd521f9b6

HEALTHCHECK NONE

ARG USER_NAME=default
ARG USER_HOME=/home/default
ARG USER_ID=1000
ARG USER_GECOS=Default

# FIXME: xml2rfc currently only in edge stream
# hadolint ignore=DL3018
RUN apk --update --no-cache add \
    html-xml-utils \
    libxml2-utils \
    libxslt \
    maven \
    py3-gpxpy \
    py3-pip \
    py3-tcx2gpx \
    python3 \
    python3-dev \
    xmlindent \
    xmlstarlet \
    xmlto \
    && rm -rf /var/cache/apk/*

# hadolint ignore=DL3013
RUN pip3 install --no-cache-dir --upgrade --break-system-packages yq

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

ENV HOME "${USER_HOME}"

USER "${USER_NAME}"

WORKDIR "${HOME}"
