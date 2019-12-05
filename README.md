# XML

Docker container with utilities to process XML data (xmllint, xsltproc...).

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
docker run --rm -it --user="$(id -u):$(id -g)" --net=none -v "$(pwd):/tmp" thomasleplus/xml xmllint --schema /tmp/foo.xsd /tmp/foo.xml --noout
```

### Windows

In `cmd`:

```
docker run --rm -it --net=none -v "%cd%:/tmp" thomasleplus/xml xmllint --schema /tmp/foo.xsd /tmp/foo.xml --noout
```

In PowerShell:

```
docker run --rm -it --net=none -v "${PWD}:/tmp" thomasleplus/xml xmllint --schema /tmp/foo.xsd /tmp/foo.xml --noout
```

## Help

To know more command line options of `xmllint`:

```
docker run --rm --net=none thomasleplus/xml xmllint --help
```
