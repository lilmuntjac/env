#!/usr/bin/env bash

# exit on error
set -eo pipefail

# extends the sudo timeout for another 5 minutes
sudo -v

sudo dnf install -y nvtop

# AMD and Intel Dependencies
# sudo dnf install -y libdrm-devel systemd-devel
# nvtop and its dependency
# sudo dnf install -y cmake ncurses-devel git gcc-c++
# cd /tmp
# git clone https://github.com/Syllo/nvtop.git
# mkdir -p nvtop/build && cd nvtop/build
# cmake .. -DNVIDIA_SUPPORT=ON -DAMDGPU_SUPPORT=ON -DINTEL_SUPPORT=ON
# make
# nvtop install globally on the system
# sudo make install
