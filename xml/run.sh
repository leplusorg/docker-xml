#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

dir=$(dirname "${0}")

\java -cp "${dir}/target/dependency/*" net.sf.saxon.Transform "${@}"
