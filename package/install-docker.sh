#!/usr/bin/env bash

# extends the sudo timeout for another 5 minutes
sudo -v

sudo dnf -y --refresh update
# add the Docker CE repository
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

# buildah is conflict with the docker, remove it
sudo dnf erase -y buildah

# install docker and docker compose
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# start the docker and testing it
sudo systemctl start docker
sudo docker run hello-world

# add current user to docker group
sudo usermod -aG docker ${USER}

echo "Done installing docker."