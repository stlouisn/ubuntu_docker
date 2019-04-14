#!/usr/bin/env bash

set -euo pipefail

# Enable docker experimental client
export DOCKER_CLI_EXPERIMENTAL="enabled"

# Login into docker
echo ${DOCKER_PASSWORD} | docker login --username ${DOCKER_USERNAME} --password-stdin

architectures="arm arm64 amd64"

for arch in $architectures
do
	buildctl build \
		--frontend dockerfile.v0 \
		--opt platform=linux/$arch \
		--opt filename=./Dockerfile.$arch \
		--local dockerfile=. \
		--local context=. \
		--output type=oci,dest=${DOCKER_TAG}-$arch.tar
	docker import ${DOCKER_TAG}-$arch.tar --message "${DOCKER_NAME}:${DOCKER_TAG}-$arch" ${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-$arch
done

# Build and push ARM image
#buildctl build \
#	--frontend dockerfile.v0 \
#	--opt platform=linux/arm \
#	--opt filename=./Dockerfile.arm \
#	--local dockerfile=. \
#	--local context=. \
#	--output type=oci,dest=${DOCKER_TAG}-arm.tar
#docker import ${DOCKER_TAG}-arm.tar --message "${DOCKER_NAME}:${DOCKER_TAG}-arm" ${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-arm

# Build and push ARM64 image

# Build and push AMD64 image
#buildctl build \
#	--frontend dockerfile.v0 \
#	--opt platform=linux/amd64 \
#	--opt filename=./Dockerfile.amd64 \
#	--local dockerfile=. \
#	--local context=. \
#	--output type=oci,dest=${DOCKER_TAG}-amd64.tar
#docker import ${DOCKER_TAG}-amd64.tar --message "${DOCKER_NAME}:${DOCKER_TAG}-amd64" ${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-amd64
