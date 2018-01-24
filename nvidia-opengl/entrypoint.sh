#! /bin/bash

# Re-mount the docker volumes mounted at runtime in the 'extern' volume
# to a 'host_files' folder inside the container user's HOME folder
sudo mkdir -p /home/$USER/host_files
# Do a recursive mount
sudo mount --rbind /extern $HOME/host_files

# Change owner from root
sudo chown $USER:$USER -R $HOME/host_files/

exec $@