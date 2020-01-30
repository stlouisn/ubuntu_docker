#!/usr/bin/env bash

set -euo pipefail

# Output OS version from ubuntu:rolling releases
echo "$(curl -fsSL --retry 5 --retry-delay 2 http://releases.ubuntu.com/${OS_CODENAME}/ | grep title | awk -F ' ' {'print $2'})"
