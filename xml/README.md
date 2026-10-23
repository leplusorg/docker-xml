# XML image

Build context for the `leplusorg/xml` container image. See the
[root readme](../README.md) for what the image does and how to run it.

## Files

- `Dockerfile` — the image definition. System packages come from the base
  distribution's package manager and are pinned to exact versions here.
- `docker-compose.test.yml` — the smoke test run in CI against the built image:
  the `sut` service checks that the container runs as the non-root user (UID 1000) and that each bundled tool starts.
- `requirements.txt` — the Python tools installed in the image, with their
  pinned versions. The `Dockerfile` installs each one globally with `pipx`, in
  its own virtual environment. Lines marked `# constraint` are not installed as
  tools: they are passed to pip as constraints to pin a dependency of one of the
  tools (the comment above each one explains why).
- `package.json` — the Node.js tools installed in the image, with their pinned
  versions. The `Dockerfile` installs each entry of `dependencies` globally with
  `npm install -g`.
- `package-lock.json` — the full npm dependency tree resolved from
  `package.json`, including transitive dependencies. It is not used by the image
  build, so the transitive versions actually installed in the image can differ
  from the ones recorded here.
- `pom.xml` — the Maven project declaring the Java dependencies of the image
  (Saxon-HE). The `Dockerfile` copies it to `/opt/saxon` and runs `./mvnw
dependency:copy-dependencies` to download the jars into
  `/opt/saxon/target/dependency`. It also configures the OWASP dependency-check
  scan, which only runs when `NVD_API_KEY` is set.
- `mvnw`, `mvnw.cmd`, `.mvn/wrapper/maven-wrapper.properties` — the Maven
  wrapper, which pins the Maven version (and its checksum) used to resolve
  `pom.xml`. `mvnw` and `.mvn/` are copied into the image; `mvnw.cmd` is the
  Windows variant, for local use only.
- `run.sh` — copied to `/opt/saxon/run.sh`; runs Saxon's
  `net.sf.saxon.Transform` with the downloaded jars on the classpath.
- `node_modules/` — created by a local `npm install`; ignored by git and not
  part of the image.
- `target/` — local Maven build output; ignored by git and not part of the image
  (the image has its own `/opt/saxon/target`, created during the build).

## Manifests

The manifests (`requirements.txt`, `package.json`, `pom.xml`) expose the pinned
versions of some of the packages and tools included in the image in a
machine-readable format. They can be used to generate an SBOM, and they are kept
up to date automatically by Dependabot (see
[`dependabot.yml`](../.github/dependabot.yml)); Renovate would work too.
