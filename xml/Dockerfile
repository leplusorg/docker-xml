FROM openjdk:15-slim

RUN mkdir -p /usr/share/man/man1/ && apt-get update && apt-get install -y \
    libxml2-utils \
    xsltproc \
    maven \
    python3-pip \
    && rm -rf /var/cache/apk/*

RUN pip3 install --no-cache-dir \
    yq

COPY pom.xml /opt/pom.xml

RUN mvn -f /opt/pom.xml dependency:copy-dependencies -DoutputDirectory=/opt
