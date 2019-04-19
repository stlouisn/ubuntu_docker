#!/usr/bin/env bash

set -euo pipefail

# Architectures to build
architectures="arm arm64 amd64"

for arch in $architectures; do

	# Build temporary image
	buildctl build \
		--frontend dockerfile.v0 \
		--opt platform=linux/$arch \
		--opt filename=docker/Dockerfile.${DOCKER_NAME}-${DOCKER_TAG}-$arch \
		--local dockerfile=. \
		--local context=. \
		--output type=docker,name=tmp-image-$arch,dest=tmp-image-$arch.tar

	# Load temporary image
	docker load -i tmp-image-$arch.tar

	# Run temporary image
	docker create --name tmp-image-$arch tmp-image-$arch '/bin/bash -c exit'

	# Extract flattened image
	docker export -o import-image-$arch.tar tmp-image-$arch

	# Create docker image
	docker import \
		import-image-$arch.tar \
		--message 'Imported from ${DOCKER_NAME}/${DOCKER_TAG}' \
		${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-$arch

	# Login into docker
	echo ${DOCKER_PASSWORD} | docker login --username ${DOCKER_USERNAME} --password-stdin

	# Push image to docker hub
	docker push ${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-$arch

done
