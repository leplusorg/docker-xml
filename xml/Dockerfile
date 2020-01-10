FROM alpine:latest

RUN apk --update --no-cache add libxml2-utils libxslt \
    && rm -rf /var/cache/apk/*

RUN pip3 install --no-cache-dir \
    yq
