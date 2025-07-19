#!/usr/bin/env bash

# exit on error
set -eo pipefail

# extends the sudo timeout for another 5 minutes
sudo -v

# install nvidia driver from ELRepo
# add the ELRepo pubilc keys
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-v2-elrepo.org

# Install ELRepo and NVIDIA Proprietary Driver
sudo dnf install -y https://www.elrepo.org/elrepo-release-9.el9.elrepo.noarch.rpm
sudo dnf --enablerepo=elrepo-kmod install -y kmod-nvidia nvidia-x11-drv
