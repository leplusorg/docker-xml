FROM eclipse-temurin:21-jdk

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
    && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3013
RUN pip3 install --no-cache-dir --upgrade \
    yq

COPY pom.xml mvnw /opt/

COPY .mvn/ /opt/.mvn/

WORKDIR /opt

RUN ./mvnw dependency:copy-dependencies

WORKDIR /
