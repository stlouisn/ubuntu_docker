#!/usr/bin/env bash

set -euo pipefail

# Build variables
BUILD_DATE="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

# OS version
OS_CODENAME="$(curl -fsSL https://raw.githubusercontent.com/tianon/docker-brew-ubuntu-core/master/latest)"
OS_VERSION="$(curl -fsSL --retry 5 --retry-delay 2 http://releases.ubuntu.com/$OS_CODENAME/ | grep title | awk -F ' ' {'print $2'})"

# Container version
C_VERSION="$OS_VERSION"

# Container variables
C_DESCRIPTION="ubuntu base image"
C_MAINTAINER="stlouisn"
C_NAME="ubuntu"
C_URL="https://www.ubuntu.com/"

# Schema version
SCHEMA_VERSION="1.0"

# Output labels to console
echo build_date = $BUILD_DATE
echo maintainer = $C_MAINTAINER
echo image_name = $C_NAME:$C_TAG
echo description = $C_DESCRIPTION
echo url = $C_URL
echo image_version = $C_VERSION

cat dockerfile

# Append labels to dockerfile
cat <<- EOF >> dockerfile

LABEL \
	org.label-schema.build-date="$BUILD_DATE" \
	org.label-schema.description="$C_DESCRIPTION" \
	org.label-schema.maintainer="$C_MAINTAINER" \
	org.label-schema.name="$C_NAME" \
	org.label-schema.url="$C_URL" \
	org.label-schema.version="$C_VERSION" \
	org.label-schema.schema-version="$SCHEMA_VERSION"
EOF

cat dockerfile