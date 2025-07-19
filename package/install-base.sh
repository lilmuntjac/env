#!/usr/bin/env bash

# exit on error
set -eo pipefail

# extends the sudo timeout for another 5 minutes
sudo -v

sudo dnf install -y epel-release
sudo dnf config-manager --set-enabled crb
sudo dnf -y upgrade
sudo dnf groupinstall -y "Development Tools"
sudo dnf -y makecache

# time sync
sudo dnf -y install chrony
sudo sed -i 's|^pool .*|server tick.stdtime.gov.tw iburst|' /etc/chrony.conf
sudo systemctl restart chronyd
sudo systemctl enable chronyd
sudo chronyc makestep

# common monitor tools
sudo dnf install -y htop 

# common use package
sudo dnf install -y tar wget curl git tmux zsh
             
# python build dependency
sudo dnf install -y make gcc patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel libuuid-devel gdbm-libs libnsl2

echo "Done installing base environment."
