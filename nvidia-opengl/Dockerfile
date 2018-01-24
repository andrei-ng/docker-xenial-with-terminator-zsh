# Based on the generic image
FROM codookie/xenial:terminator-zsh

MAINTAINER Andrei Gherghescu <gandrein@gmail.com>

LABEL Description="Ubuntu Xenial 16.04 with custom shell environment with Nvidia & OpenGL support" Version="1.0"

# nvidia-docker hooks
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}
