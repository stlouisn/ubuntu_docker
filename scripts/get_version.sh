#!/usr/bin/env bash

set -euo pipefail

# OS version
OS_CODENAME="$(curl -fsSL https://raw.githubusercontent.com/tianon/docker-brew-ubuntu-core/master/latest)"
OS_VERSION="$(curl -fsSL --retry 5 --retry-delay 2 http://releases.ubuntu.com/$OS_CODENAME/ | grep title | awk -F ' ' {'print $2'})"

# Application version
APP_VERSION="$OS_VERSION"
echo 'export C_VERSION="$APP_VERSION"' >> $BASH_ENV
echo "$APP_VERSION"