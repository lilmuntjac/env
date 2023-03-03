#!/usr/bin/env bash

# exit on error
set -eo pipefail

# extends the sudo timeout for another 5 minutes
sudo -v

# install nvidia driver 
sudo dnf config-manager --add-repo=https://developer.download.nvidia.com/compute/cuda/repos/rhel9/x86_64/cuda-rhel9.repo
sudo dnf -y module install nvidia-driver:latest-dkms