# XML

Multi-platform Docker container with utilities to process XML data (`xmllint`, `xsltproc`, `xmlindent`, `xmlto`...).

[![Dockerfile](https://img.shields.io/badge/GitHub-Dockerfile-blue)](xml/Dockerfile)
[![Docker Build](https://github.com/leplusorg/docker-xml/workflows/Docker/badge.svg)](https://github.com/leplusorg/docker-xml/actions?query=workflow:"Docker")
[![Docker Stars](https://img.shields.io/docker/stars/leplusorg/xml)](https://hub.docker.com/r/leplusorg/xml)
[![Docker Pulls](https://img.shields.io/docker/pulls/leplusorg/xml)](https://hub.docker.com/r/leplusorg/xml)
[![Docker Version](https://img.shields.io/docker/v/leplusorg/xml?sort=semver)](https://hub.docker.com/r/leplusorg/xml)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/10067/badge)](https://bestpractices.coreinfrastructure.org/projects/10067)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/leplusorg/docker-xml/badge)](https://securityscorecards.dev/viewer/?uri=github.com/leplusorg/docker-xml)

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
docker run --rm -t --user="$(id -u):$(id -g)" --net=none -v "$(pwd):/tmp" leplusorg/xml java -jar /opt/saxon/run.sh -s:/tmp/source.xml -xsl:/tmp/stylesheet.xsl -o:/tmp/output.xml
```

See [Saxon's documentation](https://www.saxonica.com/documentation12/index.html#!using-xsl/commandline) for more details regarding syntax and options.

## Help

To know more command-line options of `xmllint`:

```bash
docker run --rm --net=none leplusorg/xml xmllint --help
```

## NPM Packages

Use the `npx` command to run command-line tools coming from npm
packages. This ensures isolation between the different packages
(including potentially conflicting dependencies).

## Software Bill of Materials (SBOM)

To get the SBOM for the latest image (in SPDX JSON format), use the
following command:

```bash
docker buildx imagetools inspect leplusorg/xml --format '{{ json (index .SBOM "linux/amd64").SPDX }}'
```

Replace `linux/amd64` by the desired platform (`linux/amd64`, `linux/arm64` etc.).

## Sigstore

[Sigstore](https://docs.sigstore.dev) is trying to improve supply
chain security by allowing you to verify the origin of an
artifcat. You can verify that the image that you use was actually
produced by this repository. This means that if you verify the
signature of the Docker image, you can trust the integrity of the
whole supply chain from code source, to CI/CD build, to distribution
on Maven Central or whever you got the image from.

You can use the following command to verify the latest image using its
sigstore signature attestation:

```bash
cosign verify leplusorg/xml --certificate-identity-regexp 'https://github\.com/leplusorg/docker-xml/\.github/workflows/.+' --certificate-oidc-issuer 'https://token.actions.githubusercontent.com'
```

The output should look something like this:

```text
Verification for index.docker.io/leplusorg/xml:main --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - Existence of the claims in the transparency log was verified offline
  - The code-signing certificate was verified using trusted certificate authority certificates

[{"critical":...
```

For instructions on how to install `cosign`, please read this [documentation](https://docs.sigstore.dev/cosign/system_config/installation/).

## Request new tool

Please use [this link](https://github.com/leplusorg/docker-xml/issues/new?assignees=thomasleplus&labels=enhancement&template=feature_request.md&title=%5BFEAT%5D) (GitHub account required) to request that a new tool be added to the image. I am always interested in adding new capabilities to these images.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## Security

Please read [SECURITY.md](SECURITY.md) for details on our security policy and how to report security vulnerabilities.

## Code of Conduct

Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for details on our code of conduct.

## License

This project is licensed under the terms of the [LICENSE](LICENSE) file.
