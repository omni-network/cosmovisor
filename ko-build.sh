#!/usr/bin/env bash

export KO_DOCKER_REPO="omniops/cosmovisor"

TAG=$(git tag --points-at HEAD)
LOCAL=""
PLATFORM="all"
if [ -z "${TAG}" ]; then
  echo "Building dirty image for local testing on MacOS (not pushing)"
  TAG="dirty"
  LOCAL="--local"
  PLATFORM="linux/arm64"
fi
echo "Building omniops/cosmovisor:${TAG}"

ko build ${LOCAL} \
  --bare \
  --platform=${PLATFORM} \
  --tags="${TAG}" \
  --sbom=none \
  ./cmd/cosmovisor