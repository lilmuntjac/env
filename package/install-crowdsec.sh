#!/usr/bin/env bash

# exit on error
set -eo pipefail

CONFIG_PATH="/etc/crowdsec/parsers/s02-enrich/custom_whitelist.yaml"

# extends the sudo timeout for another 5 minutes
sudo -v

cd /tmp
curl -s https://install.crowdsec.net | sudo sh

sudo dnf install -y crowdsec
sudo dnf install -y crowdsec-firewall-bouncer-nftables

if [[ ! -e ${CONFIG_PATH} ]]; then
    sudo touch ${CONFIG_PATH}
    sudo tee -a ${CONFIG_PATH} > /dev/null <<EOT
name: crowdsecurity/whitelists
description: "Whitelist events from facility ipv4 addresses"
whitelist:
  reason: "facility ip ranges"
  ip:
    - "127.0.0.1"
  cidr:
    - "140.112.0.1/16"
    - "172.16.0.1/16"
EOT
fi

sudo systemctl reload crowdsec
