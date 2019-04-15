# Builds to trigger

set -x

builds="java_docker python_docker mono_docker traefik_docker openvpn_docker"

for build in $builds
do

  # Trigger build
  curl -X POST \
    -H "Content-Type: application/json" \
    -H "Travis-API-Version: 3" \
    -H "Accept: application/json" \
    -H "Authorization: token ${TRAVIS_API_TOKEN}" \
    -d '{"request": {"message": "Push from ${DOCKER_MAINTAINER}/${DOCKER_NAME}", "branch": "master"}}' \
    'https://api.travis-ci.org/repo/${DOCKER_MAINTAINER}/$build/requests'

done
