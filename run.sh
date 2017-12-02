#!/usr/bin/env bash

# Check args
if [ "$#" -lt 1 ]; then
  echo "usage: ./run.sh IMAGE_NAME"
  return 1
fi

set -e

IMAGE_NAME=$1 && shift 1

# Run the container with shared X11, shared network interface
docker run --rm \
  --net=host \
  --ipc=host \
  --privileged \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v $HOME/.Xauthority:/root/.Xauthority -e XAUTHORITY=/root/.Xauthority \
  -e DISPLAY=$DISPLAY \
  -v $HOME/Projects/devs/ROS:/extern/ROS \
  -it $IMAGE_NAME "$@"