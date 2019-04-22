#!/usr/bin/env bash

set -u

# Architectures to build
ARCHITECTURES="arm arm64 amd64"

for ARCH in $ARCHITECTURES; do

	# Set dockerfile directory/filename
	DOCKERFILE="dockerfiles/${DOCKER_NAME}_${DOCKER_TAG}_${ARCH}.dockerfile"

	# Build temporary image
	buildctl build \
		--frontend dockerfile.v0 \
		--progress plain \
		--opt platform=linux/${ARCH} \
		--opt filename=${DOCKERFILE} \
		--local dockerfile=. \
		--local context=. \
		--output type=docker,name=tmp-image-${ARCH},dest=tmp-image-${ARCH}.tar

	# Load temporary image
	docker load -i tmp-image-${ARCH}.tar

	# Run temporary image
	docker create --name tmp-image-${ARCH} tmp-image-${ARCH} '/bin/bash -c exit'

	# Extract flattened image
	docker export -o import-image-${ARCH}.tar tmp-image-${ARCH}

	# Create docker image
	docker import \
		import-image-${ARCH}.tar \
		--message 'Imported from ${DOCKER_NAME}/${DOCKER_TAG}' \
		${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-${ARCH}

	# Login into docker
	echo ${DOCKER_PASSWORD} | docker login --username ${DOCKER_USERNAME} --password-stdin

	# Push image to docker hub
	docker push ${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}-${ARCH}

done
