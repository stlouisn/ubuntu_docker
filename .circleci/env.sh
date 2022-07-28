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