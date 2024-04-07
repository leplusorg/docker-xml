# XML

Docker container with utilities to process XML data (xmllint, xsltproc...).

[![Docker Build](https://github.com/leplusorg/docker-xml/workflows/Docker/badge.svg)](https://github.com/leplusorg/docker-xml/actions?query=workflow:"Docker")
[![Docker Stars](https://img.shields.io/docker/stars/leplusorg/xml)](https://hub.docker.com/r/leplusorg/xml)
[![Docker Pulls](https://img.shields.io/docker/pulls/leplusorg/xml)](https://hub.docker.com/r/leplusorg/xml)
[![Docker Version](https://img.shields.io/docker/v/leplusorg/xml?sort=semver)](https://hub.docker.com/r/leplusorg/xml)

## Example not using the filesystem

Let's say that you have a file `foo.xml` that you want to reformat and save the result to `bar.xml`:

**Mac/Linux**

```bash
cat foo.xml | docker run --rm -i --net=none leplusorg/xml xmllint - > bar.xml
```

**Windows**

```batch
type foo.xml | docker run --rm -i --net=none leplusorg/xml xmllint - > bar.xml
```

## Example requiring the filesystem

Assuming that you have a file `foo.xml` in your current working directory that you want to validate using `foo.xsd`:

**Mac/Linux**

```bash
docker run --rm -t --user="$(id -u):$(id -g)" --net=none -v "$(pwd):/tmp" leplusorg/xml xmllint --schema /tmp/foo.xsd /tmp/foo.xml --noout
```

**Windows**

In `cmd`:

```batch
docker run --rm -t --net=none -v "%cd%:/tmp" leplusorg/xml xmllint --schema /tmp/foo.xsd /tmp/foo.xml --noout
```

In PowerShell:

```pwsh
docker run --rm -t --net=none -v "${PWD}:/tmp" leplusorg/xml xmllint --schema /tmp/foo.xsd /tmp/foo.xml --noout
```

## XSLT with Saxon HE

```bash
docker run --rm -t --user="$(id -u):$(id -g)" --net=none -v "$(pwd):/tmp" leplusorg/xml java -jar /opt/Saxon-HE-9.9.1-7.jar -s:/tmp/source.xml -xsl:/tmp/stylesheet.xsl -o:/tmp/output.xml
```

## Help

To know more command-line options of `xmllint`:

```bash
docker run --rm --net=none leplusorg/xml xmllint --help
```

## Request new tool

Please use [this link](https://github.com/leplusorg/docker-xml/issues/new?assignees=thomasleplus&labels=enhancement&template=feature_request.md&title=%5BFEAT%5D) (GitHub account required) to request that a new tool be added to the image. I am always interested in adding new capabilities to these images.
