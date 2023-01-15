FROM eclipse-temurin:17-jdk

# hadolint ignore=DL3008
RUN mkdir -p /usr/share/man/man1/ && apt-get update && apt-get install --no-install-recommends -y \
    libxml2-utils \
    xsltproc \
    maven \
    python3-pip \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3013
RUN pip3 install --no-cache-dir \
    yq

COPY pom.xml mvnw /opt/

COPY .mvn/ /opt/.mvn/

WORKDIR /opt

RUN ./mvnw dependency:copy-dependencies

WORKDIR /
