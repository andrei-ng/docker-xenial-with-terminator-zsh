#!/usr/bin/env bash

# Check args
if [ "$#" -ne 1 ]; then
  echo "usage: ./build.sh GIVEN_IMAGE_NAME"
  return 1
fi

# Build the docker image and specify a user name (default=docker)
# and a UID value (default current user's UID)
docker build \
  --build-arg user=docker\
  --build-arg uid=$UID\
  -t $1 .