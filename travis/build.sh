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

	docker import \
		${DOCKER_TAG}-$arch.tar \
		--message "${DOCKER_NAME}:${DOCKER_TAG}-$arch" \
		${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-$arch

	docker push ${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-$arch
done
