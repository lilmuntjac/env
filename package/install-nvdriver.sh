#!/usr/bin/env bash

# extends the sudo timeout for another 5 minutes
sudo -v

# change to /tmp
# cd /tmp

# useful variables
DRIVER_VERSION="525.53" # CUDA Version: 12.0
DRIVER_INSTALLER="NVIDIA-Linux-x86_64-${DRIVER_VERSION}.run"
DRIVER_LINK="http://us.download.nvidia.com/XFree86/Linux-x86_64/${DRIVER_VERSION}/${DRIVER_INSTALLER}"

# Install needed packages
sudo dnf install -y kernel-devel kernel-headers gcc make dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig

# download installer
printf "Downlodaing NVIDIA driver ${DRIVER_VERSION} installer... "
curl -sSL "${DRIVER_LINK}" -o "${DRIVER_INSTALLER}"
chmod +x "${DRIVER_INSTALLER}"
echo "Done."

# install NVIDIA driver
printf "Installing NVIDIA driver ${DRIVER_VERSION}... "
sudo ./"${DRIVER_INSTALLER}" --silent --dkms --run-nvidia-xconfig
echo "Done."

# clean up
# rm "${DRIVER_INSTALLER}"