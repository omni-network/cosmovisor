#!/usr/bin/env bash

export KO_DOCKER_REPO="omniops/cosmovisor"

TAG=$(git tag --points-at HEAD)
if [ -z "${TAG}" ]; then
  TAG="dirty"
fi
echo "Building omniops/cosmovisor:${TAG}"

ko build \
  --bare \
  --platform="all" \
  --tags="${TAG}" \
  --sbom=none \
  ./cmd/cosmovisor