#!/usr/bin/env bash

set -euo pipefail

# Enable docker experimental client
export DOCKER_CLI_EXPERIMENTAL="enabled"

# Login into docker
echo ${DOCKER_PASSWORD} \| docker login --username ${DOCKER_USERNAME} --password-stdin

architectures="arm arm64 amd64"

for arch in $architectures
do
	buildctl build \
		--progress=plain \
		--frontend dockerfile.v0 \
		--opt platform=linux/$arch \
		--opt filename=./Dockerfile.$arch \
		--local dockerfile=. \
		--local context=. \
		--output type=docker,name=tmp-image-$arch \| docker load

	docker create --name tmp-container-$arch tmp-image-$arch /bin/bash -c exit
	
	docker export -o tmp-file-$arch.tar tmp-container-$arch

	docker import \
		tmp-file-$arch.tar \
		--message "Imported from ${DOCKER_NAME}/${DOCKER_TAG}" \
		${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-$arch

	docker push ${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-$arch
done
