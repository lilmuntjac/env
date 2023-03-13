#!/usr/bin/env bash

# exit on error
set -eo pipefail

# change to /tmp
cd /tmp

# install needed packages
sudo dnf install zlib

# install function
install () {
  CUDA_VERSION=$1
  CUDNN_VERSION=$2
  CUDA_LINK=$3
  CUDNN_LINK=$4

  # download cuda installer
  printf "Downlodaing CUDA ${CUDA_VERSION} installer... "
  curl -sSL "${CUDA_LINK}" -o cuda.run
  chmod +x cuda.run
  echo "Done."

  # download cudnn tar.xz
  printf "Downloading cuDNN ${CUDNN_VERSION} packages... "
  curl -sSL "${CUDNN_LINK}" -o cudnn.tar.xz
  echo "Done."
  
  # extends the sudo timeout for another 5 minutes
  sudo -v

  # install CUDA toolkit
  printf "Installing CUDA ${CUDA_VERSION}... "
  sudo ./cuda.run --silent --toolkit --override
  echo "Done."

  # install cuDNN library
  printf "Installing cuDNN ${CUDNN_VERSION}... "
  sudo tar --no-same-owner -xvf cudnn.tar.xz 
  # copy the following files into the CUDA toolkit directory
  sudo cp cudnn-*-archive/include/cudnn*.h /usr/local/cuda/include
  sudo cp -P cudnn-*-archive/lib/libcudnn* /usr/local/cuda/lib64
  sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
  echo "Done."

  # remove default symbloic link
  sudo rm /usr/local/cuda

  # clean up
  rm cuda.run cudnn.tar.xz
  rm -r cudnn-*-archive
}

install "10.2" "8.5.0" \
    "https://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run" \
    "https://developer.download.nvidia.com/compute/redist/cudnn/v8.5.0/local_installers/10.2/cudnn-linux-x86_64-8.5.0.96_cuda10-archive.tar.xz"
    
# install "11.6" "8.5.0" \
#     "https://developer.download.nvidia.com/compute/cuda/11.6.2/local_installers/cuda_11.6.2_510.47.03_linux.run" \
#     "https://developer.download.nvidia.com/compute/redist/cudnn/v8.5.0/local_installers/11.7/cudnn-linux-x86_64-8.5.0.96_cuda11-archive.tar.xz"

install "11.8" "8.7.0" \
    "https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run" \
    "https://developer.download.nvidia.com/compute/redist/cudnn/v8.7.0/local_installers/11.8/cudnn-linux-x86_64-8.7.0.84_cuda11-archive.tar.xz"
    
# default use cuda-11.8
ln -fns /usr/local/cuda-11.8 ~/.cuda
sudo ln -fns /usr/local/cuda-11.8 /etc/skel/.cuda