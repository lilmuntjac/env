#!/usr/bin/env bash

# some useful variable
REPO_LINK="https://github.com/lilmuntjac/env"
INSTALL_PATH="/opt/env"

# Package
cd ${INSTALL_PATH}/package

sudo bash install-nvdriver.sh
sudo bash install-nvtop.sh
sudo bash install-cudacudnn.sh

while getopts 'p' flag; do
  case "$flag" in
    p)
    # start the NVIDIA Persistence Daemon
    sudo cp -f ${INSTALL_PATH}/configs/nvidia-persistenced.service /lib/systemd/system/nvidia-persistenced.service
    sudo systemctl enable --now nvidia-persistenced
    ;;
  esac
done