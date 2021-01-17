# XML

Docker container with utilities to process XML data (xmllint, xsltproc...).

[![Docker Build](https://github.com/thomasleplus/docker-xml/workflows/Docker/badge.svg)](https://github.com/thomasleplus/docker-xml/actions?query=workflow:"Docker")
[![Docker Stars](https://img.shields.io/docker/stars/thomasleplus/xml)](https://hub.docker.com/r/thomasleplus/xml)
[![Docker Pulls](https://img.shields.io/docker/pulls/thomasleplus/xml)](https://hub.docker.com/r/thomasleplus/xml)
[![Docker Automated](https://img.shields.io/docker/cloud/automated/thomasleplus/xml)](https://hub.docker.com/r/thomasleplus/xml)
[![Docker Build](https://img.shields.io/docker/cloud/build/thomasleplus/xml)](https://hub.docker.com/r/thomasleplus/xml)
[![Docker Version](https://img.shields.io/docker/v/thomasleplus/xml?sort=semver)](https://hub.docker.com/r/thomasleplus/xml)

## Example not using the filesystem

Let's say that you have a file `foo.xml` that you want to reformat and save the result to `bar.xml`:

### Mac/Linux

```
cat foo.xml | docker run --rm -i --net=none thomasleplus/xml xmllint - > bar.xml
```

### Windows

```
type foo.xml | docker run --rm -i --net=none thomasleplus/xml xmllint - > bar.xml
```

## Example requiring the filesystem

Assuming that you have a file `foo.xml` in your current working directory that you want to validate using `foo.xsd`:

### Mac/Linux

```
docker run --rm -t --user="$(id -u):$(id -g)" --net=none -v "$(pwd):/tmp" thomasleplus/xml xmllint --schema /tmp/foo.xsd /tmp/foo.xml --noout
```

### Windows

In `cmd`:

```
docker run --rm -t --net=none -v "%cd%:/tmp" thomasleplus/xml xmllint --schema /tmp/foo.xsd /tmp/foo.xml --noout
```

In PowerShell:

```
docker run --rm -t --net=none -v "${PWD}:/tmp" thomasleplus/xml xmllint --schema /tmp/foo.xsd /tmp/foo.xml --noout
```

## XSLT with Saxon HE

```
docker run --rm -t --user="$(id -u):$(id -g)" --net=none -v "$(pwd):/tmp" thomasleplus/xml java -jar /opt/Saxon-HE-9.9.1-7.jar -s:/tmp/source.xml -xsl:/tmp/stylesheet.xsl -o:/tmp/output.xml
```

## Help

To know more command line options of `xmllint`:

```
docker run --rm --net=none thomasleplus/xml xmllint --help
```

## Request new tool

Please use [this link](https://github.com/thomasleplus/docker-xml/issues/new?assignees=thomasleplus&labels=enhancement&template=feature_request.md&title=%5BFEAT%5D) (GitHub account required) to request that a new tool be added to the image. I am always interested in adding new capabilities to these images.
