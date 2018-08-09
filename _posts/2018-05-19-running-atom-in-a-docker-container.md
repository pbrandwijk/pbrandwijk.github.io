---
layout: post
title:  "Running Atom in a Docker container"
date:   2018-05-19 14:20:00 +0200
tags:
 - linux
 - security
 - docker
 - atom
---
*If you do not want to install Atom directly on your system, you can run it in a Docker container.*

## Preliminaries
I'm using Ubuntu 18.04 as my OS. If you don't have docker installed yet, run:
```console
$ sudo install docker docker.io     # Install Docker libs
$ sudo systemctl status docker      # Check if Docker daemon is active
$ sudo groupadd docker              # Add 'docker' group if it doesn't already exist
$ sudo gpasswd -a $USER docker      # Add the 'docker' group to current user
$ newgrp docker                     # Apply the new group membership without log out
$ id -nG                            # Check that group was added to user
```

## Getting the Docker image
I use a Docker image for this called `jamesnetherton/docker-atom-editor`. To pull it to your system run:
```console
$ docker pull jamesnetherton/docker-atom-editor
```

## Running the container
With the following command, you can run Atom in a container:
```console
$ docker run -d -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
                -v /dev/shm:/dev/shm \
                -v ${HOME}/.atom:/home/atom/.atom \
                -e DISPLAY jamesnetherton/docker-atom-editor
```

This runs Atom, but gives it no access to files on your system. To do this, you need to add the folder you want to the container. In the following example, I give the container access to `${HOME}/development`:

```console
$ docker run -d -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
                -v /dev/shm:/dev/shm \
                -v ${HOME}/.atom:/home/atom/.atom \
                -v ${HOME}/development:/home/atom \
                -e DISPLAY jamesnetherton/docker-atom-editor
```


# Resources
- [Docker Atom editor][github]
- [How To Install and Use Docker on Ubuntu][digitalocean]

[github]: https://github.com/jamesnetherton/docker-atom-editor
[digitalocean]: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04
