FROM openjdk:16-alpine

RUN apk --update --no-cache add libxml2-utils libxslt maven py3-setuptools py3-pip \
    && rm -rf /var/cache/apk/*

RUN pip3 install --no-cache-dir \
    yq

COPY pom.xml /opt/pom.xml

RUN mvn -f /opt/pom.xml dependency:copy-dependencies -DoutputDirectory=/opt
