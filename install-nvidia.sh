#!/usr/bin/env bash

# exit on error
set -eo pipefail

# some useful variable
REPO_LINK="https://github.com/lilmuntjac/env"
INSTALL_PATH="/opt/env"

# Package
cd ${INSTALL_PATH}/package

sudo bash install-nvdriver.sh
sudo bash install-nvtop.sh

while getopts 'p' flag; do
  case "$flag" in
    p)
    # start the NVIDIA Persistence Daemon
    sudo systemctl enable --now nvidia-persistenced.service
    ;;
  esac
done
