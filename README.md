## Docker Image Customization Example

This repository is an example of a Docker Image customization having as base image dockerhub's Ubuntu 16.04 (Xenial).

The image is customized such that 
* the docker image is created with a non-root user
* [Oh My ZSH](http://ohmyz.sh/) is installed and configured for the non-root user
* docker containers are launched with [`terminator`](https://gnometerminator.blogspot.nl/p/introduction.html) as the default application (`gnome-terminal` could have been used as well)
* host mounted volumes are re-bound to a `data` folder within the container's user `$HOME` folder 

### Purpose

Experimentation ...

### Building the image

In a terminal run [./build.sh](./build.sh) to build a docker image with the name provided as the first argument and with a specified `non-root` user (`default=docker`) for the docker container.

```
./build.sh GIVEN_IMAGE_NAME
```

#### The start-up `inside.sh` script
The bash script [inside.sh](./inside.sh) will be copied at build time into the Docker image and will be ran each time the container is ran. The script currently _bind mounts_ the `extern` _volume_ into the `$HOME/data` folder of the `non-root` user.

### Running a container

In a terminal run [./run.sh](./run.sh) with the name chosen in the previous step. This will run and remove the docker image upon exit (i.e., it is ran with the `--rm` flag).

```
./run.sh GIVEN_IMAGE_NAME
```

Whatever data you require from the host, mount it in the container's `extern` folder, e.g. following the bellow structure 
```
  -v $HOME/Projects/ROS:/extern/ROS 
```
When the container is launched, the data in the `extern` folder will also be available in the docker user's `$HOME/data` folder. 

The image also shares the X11 unix socket with the host and its network interface.

#### Running Firefox from within the container

Run the container and install Firefox from the terminal, 
```
sudo apt install firefox
```
After installation, launch Firefox from the terminal. You are now running Firefox from a Docker container :smiley:.

## References

The `Oh My ZSH` and `terminator` configuration based on 
* [turlucode/ros-docker-gui/](https://github.com/turlucode/ros-docker-gui/)

The script(s) structure and user creation adapted from
* [jbohren/rosdocked](https://github.com/jbohren/rosdocked)
