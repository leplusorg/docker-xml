FROM alpine:3.22.2@sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412

HEALTHCHECK NONE

ARG USER_NAME=default
ARG USER_HOME=/home/default
ARG USER_ID=1000
ARG USER_GECOS=Default

SHELL ["/bin/ash", "-euo", "pipefail", "-c"]

# @TL FIXME: xml2rfc currently only in edge stream
RUN apk upgrade --no-cache \
    && apk add --no-cache \
    aspell=0.60.8.1-r0 \
    aspell-de=20161207.7.0-r0 \
    aspell-en=2020.12.07-r0 \
    aspell-fr=0.50.3-r0 \
    aspell-ru=0.99_p7-r2 \
    aspell-uk=1.4.0-r3 \
    coreutils=9.7-r1 \
    curl=8.14.1-r2 \
    dasel=2.8.1-r8 \
    gawk=5.3.2-r2 \
    git=2.49.1-r0 \
    grep=3.12-r0 \
    html-xml-utils=8.7-r0 \
    libxml2-utils=2.13.9-r0 \
    libxslt=1.1.43-r3 \
    maven=3.9.9-r0 \
    npm=11.3.0-r1 \
    openjdk21-jre-headless=21.0.8_p9-r0 \
    pandoc-cli=3.6.4-r0 \
    pipx=1.7.1-r0 \
    py3-pip=25.1.1-r0 \
    python3=3.12.11-r0 \
    xmlindent=0.2.17-r3 \
    xmlsec=1.3.7-r0 \
    xmlstarlet=1.6.1-r2 \
    xmlto=0.0.29-r0 \
    yq-go=4.47.2-r0 \
    && apk cache --no-cache clean \
    && rm -rf /var/cache/apk/*

RUN pipx ensurepath --global \
    && pipx install --global \
    jsonfmt==0.2.7 \
    remarshal==1.2.0 \
    tcx2gpx==0.1.6

RUN npm install -g \
    prettier@3.6.2 \
    v8r@5.1.0

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
