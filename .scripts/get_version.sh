#!/usr/bin/env bash

set -euo pipefail

# OS version
export OS_CODENAME="$(curl -fsSL https://raw.githubusercontent.com/tianon/docker-brew-ubuntu-core/master/latest)"
export OS_VERSION="$(curl -fsSL --retry 5 --retry-delay 2 http://releases.ubuntu.com/${OS_CODENAME}/ | grep title | awk -F ' ' {'print $2'})"

# Container version
export C_VERSION="${OS_VERSION}"
echo script done