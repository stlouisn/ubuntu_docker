#!/usr/bin/env bash

set -euo pipefail

[ -f rootfs/usr/local/bin/docker_entrypoint.sh ] && chmod +x rootfs/usr/local/bin/docker_entrypoint.sh
