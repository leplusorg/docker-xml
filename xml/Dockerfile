FROM eclipse-temurin:21.0.2_13-jdk-alpine@sha256:8d6a992f7d6fe014f070a81a7f1f74afcd9bb7ace568773e44025819ba745174

HEALTHCHECK NONE

ARG USER_NAME=default
ARG USER_HOME=/home/default
ARG USER_ID=1000
ARG USER_GECOS=Default

# hadolint ignore=DL3018
RUN apk --update --no-cache add \
    gpxinfo \
    html-xml-utils \
    libxml2-utils \
    xml2rfc \
    xmlindent \
    xmlstarlet \
    xmlto \
    xsltproc \
    maven \
    python3 \
    python3-dev \
    py3-pip \
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
