FROM ubuntu:xenial

MAINTAINER Andrei Gherghescu <gandrein@gmail.com>

LABEL Description="Ubuntu Xenial 16.04 with mapped NVIDIA driver from the host" Version="1.0"

# Arguments
ARG user=docker
ARG uid=1000

# ------------------------------------------ Install required (&useful) packages --------------------------------------
RUN apt-get update && apt-get install -y \
lsb-release \
mesa-utils \
git \
subversion \
nano \
terminator \
gnome-terminal \
wget \
curl \
htop \
python3-pip python-pip  \
software-properties-common python-software-properties \
gdb \
zsh screen tree \
sudo ssh synaptic vim \
x11-apps build-essential \
libcanberra-gtk*

# Install python pip(s)
RUN sudo -H pip2 install -U pip numpy && sudo -H pip3 install -U pip numpy

# Configure timezone and locale
RUN sudo apt-get clean && sudo apt-get update -y && sudo apt-get install -y locales
RUN sudo locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  

# Crete and add user
RUN useradd -ms /bin/bash ${user}
ENV USER=${user}

RUN export uid=${uid} gid=${uid}

RUN \
  mkdir -p /etc/sudoers.d && \
  echo "${user}:x:${uid}:${uid}:${user},,,:$HOME:${shell}" >> /etc/passwd && \
  echo "${user}:x:${uid}:" >> /etc/group && \
  echo "${user} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${user}" && \
  chmod 0440 "/etc/sudoers.d/${user}"
  RUN chown ${uid}:${uid} -R "/home/${user}"

# Switch to user
USER ${user}

# Install and configure OhMyZSH
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
# RUN chsh -s /usr/bin/zsh ${user}
RUN git clone https://github.com/sindresorhus/pure $HOME/.oh-my-zsh/custom/pure
RUN ln -s $HOME/.oh-my-zsh/custom/pure/pure.zsh-theme $HOME/.oh-my-zsh/custom/
RUN ln -s $HOME/.oh-my-zsh/custom/pure/async.zsh $HOME/.oh-my-zsh/custom/
RUN sed -i -e 's/robbyrussell/refined/g' $HOME/.zshrc

# $HOME does not seem to work with the COPY directive
COPY custom_files/bash_aliases /home/${user}/.bash_aliases
COPY inside.sh /home/${user}/inside.sh
# Make user the owner of the copied files 
RUN sudo chown ${user}:${user} /home/${user}/.bash_aliases
RUN sudo chown ${user}:${user} /home/${user}/inside.sh
RUN sudo chmod +x /home/${user}/inside.sh

# Add the bash aliases to zsh rc as well
RUN cat $HOME/.bash_aliases >> $HOME/.zshrc

# Create a mount point to bind host data to
VOLUME /extern

# Make SSH available
EXPOSE 22

# Switch to user's HOME folder
WORKDIR /home/${user}

# Configure Terminator
RUN mkdir -p $HOME/.config/terminator/
COPY custom_files/terminator_config /home/${user}/.config/terminator/config

# In the newly loaded container sometimes you can't do `apt install <package>
# unless you do a `apt update` first.  So run `apt update` as last step
# NOTE: bash auto-completion may have to be enabled manually from /etc/bash.bashrc RUN apt-get update -y
# CMD ["terminator"]
ENTRYPOINT $HOME/inside.sh ; terminator


