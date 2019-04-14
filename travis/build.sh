#!/usr/bin/env bash

set -euo pipefail

# Enable docker experimental client
export DOCKER_CLI_EXPERIMENTAL="enabled"

# Login into docker
echo ${DOCKER_PASSWORD} | docker login --username ${DOCKER_USERNAME} --password-stdin

# Build and push ARM32 image
buildctl build \
	--frontend dockerfile.v0 \
	--opt platform=linux/arm32 \
	--opt filename=./Dockerfile.arm32 \
	--local dockerfile=. \
	--local context=. \
	--output type=oci,dest=${DOCKER_TAG}-arm32.tar
docker import ${DOCKER_TAG}-arm32.tar --message "${DOCKER_NAME}:${DOCKER_TAG}-arm32" ${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-arm32

# Build and push ARMHF image

# Build and push ARM64 image

# Build and push AMD64 image
buildctl build \
	--frontend dockerfile.v0 \
	--opt platform=linux/amd64 \
	--opt filename=./Dockerfile.amd64 \
	--local dockerfile=. \
	--local context=. \
	--output type=oci,dest=${DOCKER_TAG}-amd64.tar
docker import ${DOCKER_TAG}-amd64.tar --message "${DOCKER_NAME}:${DOCKER_TAG}-amd64" ${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-amd64
