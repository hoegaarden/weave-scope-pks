#!/usr/bin/env bash

set -e
set -u
set -o pipefail


readonly WEAVE_URL="${WEAVE_URL:-"https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '\n')"}"
readonly MY_DIR="$(dirname "$0")"

main() {
  local pks_patch="${MY_DIR}/pks.bosh-patch.yaml"

  curl -sL "${WEAVE_URL}" \
    | bosh -n interpolate --ops-file "${pks_patch}" - \
    | cat
}

main "$@"
