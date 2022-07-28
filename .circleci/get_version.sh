#!/usr/bin/env bash

set -euo pipefail

# OS codename/version
OS_CODENAME="$(curl -fsSL https://raw.githubusercontent.com/tianon/docker-brew-ubuntu-core/master/latest)"
OS_VERSION="$(curl -fsSL --retry 5 --retry-delay 2 http://releases.ubuntu.com/$OS_CODENAME/ | grep title | awk -F ' ' {'print $2'})"

# # App version
# APP_VERSION="$OS_VERSION"

# Container Version
echo "export C_VERSION=$OS_VERSION" >> $BASH_ENV

echo C_VERSION = $C_VERSION

env