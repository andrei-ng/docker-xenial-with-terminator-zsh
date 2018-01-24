#!/usr/bin/env bash

# Check args
if [ "$#" -ne 1 ]; then
  echo "usage: ./build.sh IMAGE_NAME"
  return 1
fi

# Set custom arguments
dUSER=docker
dSHELL=/usr/bin/zsh

# Copy default config files
cp -r ../configs configs

# Build the docker image and specify a user name (default=docker)
# and a UID value (default current user's UID)
docker build\
  --build-arg user=$dUSER\
  --build-arg uid=$UID\
  --build-arg shell=$dSHELL\
  -t $1 .

# Remove configs folder
rm -rf configs