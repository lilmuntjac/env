#!/usr/bin/env bash

# some useful variable
REPO_LINK="https://github.com/lilmuntjac/env"
INSTALL_PATH="/opt/env"
BIN_PATH="/usr/local/bin"

sudo -v

# Script
cd ${INSTALL_PATH}/variable-script
# user
for s in $(ls -A -I profile.d -I motd -I zshenv); do
  for ss in $(ls ${s}); do
    sudo ln -sfn $(pwd)/${s}/${ss} ${BIN_PATH}/${ss}
  done
done

# profile.d (run at login for bash)
for ss in $(ls -A profile.d); do
  sudo ln -sfn $(pwd)/profile.d/${ss} /etc/profile.d/${ss}
done

# motd
# silence annoying cockpit message 
sudo ln -sfn /dev/null /etc/motd.d/cockpit

sudo sed -i 's/#PrintMotd.*/PrintMotd no/g' /etc/ssh/sshd_config 

grep -xFq ${BIN_PATH}/motd/\* /etc/profile || echo ${BIN_PATH}/motd/\* | sudo tee -a /etc/profile
sudo mkdir -p ${BIN_PATH}/motd
for ss in $(ls -A motd); do
  sudo ln -sfn $(pwd)/motd/${ss} ${BIN_PATH}/motd/${ss}
done

# # make zsh source profile.d and print motd on login
# if ! grep -q /etc/profile.d /etc/zshenv; then
#   sudo cat >> /etc/zshenv << "EOF"
# if [ -d /etc/profile.d ]; then
#   for i in /etc/profile.d/*.sh; do
#     if [ -r $i ]; then
#       . $i
#     fi
#   done
#   unset i
# fi
# EOF
# fi
# if ! grep -q ${BIN_PATH}/motd/\* /etc/zshenv; then
#   sudo cat >> /etc/zshenv << EOF
# if [[ -o login ]]; then
#   ${BIN_PATH}/motd/*
# fi
# EOF
# fi