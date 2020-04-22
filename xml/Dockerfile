FROM openjdk:11-jre-slim

RUN apk --update --no-cache add libxml2-utils libxslt maven py3-setuptools \
    && rm -rf /var/cache/apk/*

RUN pip3 install --no-cache-dir \
    yq
