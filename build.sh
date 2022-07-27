#!/usr/bin/env bash

set -u

# Container Description
DOCKER_DESCRIPTION="ubuntu base image"
DOCKER_NAME="ubuntu"
DOCKER_USERNAME="stlouisn"
DOCKER_TAG="latest"
DOCKER_MAINTAINER="stlouisn"
DOCKER_URL="https://www.ubuntu.com/"
SCHEMA_VERSION="1.0"

# Build Variables
BUILD_DATE="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
OS_CODENAME="$(curl -fsSL https://raw.githubusercontent.com/tianon/docker-brew-ubuntu-core/master/latest)"

# Container Version
DOCKER_VERSION="$(curl -fsSL --retry 5 --retry-delay 2 http://releases.ubuntu.com/${OS_CODENAME}/ | grep title | awk -F ' ' {'print $2'})"

# Create temporary Dockerfile
#sed -e '/^$/d' -e 's/^[ \t]*//' -e '/^#/d' ${DOCKER_NAME}_${DOCKER_TAG}.dockerfile > Dockerfile

# Append labels to dockerfile
cat <<- EOF >> Dockerfile
LABEL \
org.label-schema.build-date="${BUILD_DATE}" \
org.label-schema.description="${DOCKER_DESCRIPTION}" \
org.label-schema.maintainer="${DOCKER_MAINTAINER}" \
org.label-schema.name="${DOCKER_NAME}" \
org.label-schema.url="${DOCKER_URL}" \
org.label-schema.version="${DOCKER_VERSION}" \
org.label-schema.schema-version="${SCHEMA_VERSION}"
EOF

# Build image
docker buildx --pull --no-cache --tag ${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG} .


# Push image to docker hub
docker push ${DOCKER_USERNAME}/${DOCKER_NAME}:${DOCKER_TAG}

# Cleanup
rm Dockerfile