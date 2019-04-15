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
    -d '{"request": {"message": "Push from stlouisn/ubuntu", "branch": "master"}}' \
    'https://api.travis-ci.org/repo/stlouisn%2F$build/requests'

done
