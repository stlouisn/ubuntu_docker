#!/usr/bin/env bash

set -euo pipefail

# Enable docker experimental client
export DOCKER_CLI_EXPERIMENTAL="enabled"

# Login into docker
echo ${DOCKER_PASSWORD} | docker login --username ${DOCKER_USERNAME} --password-stdin

# Build and push ARM32 image

# Build and push ARMHF image

# Build and push ARM64 image

# Build and push AMD64 image
buildctl build \
	--frontend dockerfile.v0 \
	--opt platform=linux/amd64 \
	--opt filename=./Dockerfile.amd64 \
	--local dockerfile=. \
	--local context=. \
	--output type=tar > ubuntu-image.tar
docker import ubuntu-image.tar --message "${DOCKER_NAME}:${DOCKER_TAG}-amd64" ${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-amd64
