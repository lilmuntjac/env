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
sudo systemctl stop chronyd
sudo chronyd -q  'server tick.stdtime.gov.tw iburst'
sudo systemctl restart chronyd

# common monitor tools
sudo dnf install -y htop 

# common use package
sudo dnf install -y tar wget curl git tmux zsh
             
# python build dependency
sudo dnf install -y make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel

echo "Done installing base environment."