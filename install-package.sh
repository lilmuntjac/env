#!/usr/bin/env bash

# Download the repo and run this file for all installation
REPO_LINK="https://github.com/Elispus/env"
INSTALL_PATH="/opt/env"

sudo git clone "${REPO_LINK}" "${INSTALL_PATH}"

# Package
cd ${INSTALL_PATH}/package

sudo bash install-base.sh
sudo bash install-docker.sh