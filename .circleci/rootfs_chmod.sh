#!/usr/bin/env bash

set -euo pipefail

for FILE in $(find rootfs/. -name '*.sh'); do
    echo $FILE
    chmod +x $FILE
done