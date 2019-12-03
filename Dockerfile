FROM alpine:latest

RUN apk --update --no-cache add jq jsonlint \
    && rm -rf /var/cache/apk/*
