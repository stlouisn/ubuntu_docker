#!/usr/bin/env bash

set -euo pipefail

# Builds to trigger
builds="java_docker mono_docker python_docker builder_docker openvpn_docker pi-hole_docker traefik_docker"

# Commit Message
body='{
"request": {
"message": "Push from stlouisn/ubuntu",
"branch": "master"
}}'

for build in $builds; do

  # Trigger build
  curl -s -X POST \
    -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    -H "Travis-API-Version: 3" \
    -H "Authorization: token ${TRAVIS_API_TOKEN}" \
    -d "$body" \
    https://api.travis-ci.org/repo/${DOCKER_MAINTAINER}%2F$build/requests

done
