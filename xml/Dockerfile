FROM eclipse-temurin:21-jdk

HEALTHCHECK NONE

# hadolint ignore=DL3008
RUN mkdir -p /usr/share/man/man1/ && apt-get update && apt-get install --no-install-recommends -y \
    gpxinfo \
    html-xml-utils \
    libxml2-utils \
    xml2rfc \
    xmlindent \
    xmlstarlet \
    xmlto \
    xsltproc \
    maven \
    python3-pip \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --no-cache-dir --upgrade yq

RUN mkdir -p /opt/saxon

COPY pom.xml mvnw run.sh /opt/saxon/

COPY .mvn/ /opt/saxon/.mvn/

WORKDIR /opt/saxon

RUN ./mvnw dependency:copy-dependencies && chmod -R o+rX /opt/saxon

ARG USER_NAME=default
ARG USER_HOME=/home/default
ARG USER_ID=1000
ARG USER_GECOS=Default

RUN adduser \
  --home "${USER_HOME}" \
  --uid "${USER_ID}" \
  --gecos "${USER_GECOS}" \
  --disabled-password \
  "${USER_NAME}"

ENV HOME "${USER_HOME}"

USER "${USER_NAME}"

WORKDIR "${HOME}"
