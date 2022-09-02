#!/usr/bin/env bash

sudo touch /etc/modprobe.d/blacklist.conf
sudo bash -c 'echo "blacklist nouveau" > /etc/modprobe.d/blacklist.conf'

# For Rocky Linux 9.0
# It replace the entire line at GRUB_CMDLINE_LINUX
old=`grep 'GRUB_CMDLINE_LINUX' /etc/default/grub`
new=${old::-1}' rd.driver.blacklist=nouveau"'
sudo sed -i "s#GRUB_CMDLINE_LINUX=.*#$new#g" /etc/default/grub

sudo grub2-mkconfig –o /boot/grub2/grub.cfg
sudo systemctl set-default multi-user.target