#!/usr/bin/env bash

# Check args
if [ "$#" -ne 1 ]; then
  echo "usage: ./build.sh IMAGE_NAME"
  return 1
fi

# Copy custom config files
cp -r ../configs configs

# Copy the generic Dockerfile and the generic entrypoint script
cp ../generic/Dockerfile .
cp ../generic/entrypoint.sh .

# Replace BASE IMAGE NAME with CUDA9 image name
BASE_IMAGE_NAME="nvidia/cuda:9.0-devel-ubuntu16.04"
sed -i '/FROM ubuntu:xenial/c\'"FROM $BASE_IMAGE_NAME" Dockerfile

# Set custom arguments
dUSER=docker
dSHELL=/usr/bin/zsh

# Build the docker image and specify a user name (default=docker)
# and a UID value (default current user's UID)
docker build\
  --build-arg user=$dUSER\
  --build-arg uid=$UID\
  --build-arg shell=$dSHELL\
  -t $1 .

# Remove configs folder
rm -rf configs