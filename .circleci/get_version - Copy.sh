#!/usr/bin/env bash

set -euo pipefail

find rootfs/. -name '*.sh' -print0 | xargs -0 chmod +x

for FILE in $(find rootfs/. -name "*.sh"); do
    echo $FILE
    chmod +x $FILE
done
