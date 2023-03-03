# Server setup
## Disable default video driver on boot
```
bash <(curl -L https://raw.githubusercontent.com/lilmuntjac/env/main/disable-videodriver.sh)
```
:exclamation: Remember to reboot the server before continue to the next step.
## Download the repository and start installation process
### Common packages
include common development tools, dependency, monitor tools, docker
```
bash <(curl -L https://raw.githubusercontent.com/lilmuntjac/env/main/install-package.sh)
```
### GPU related packages
nvidia driver, nvtop, CUDA and cuDNN
go to ```/opt/env``` to run the rest for the script, flag ```-p``` for enable NVIDIA Persistence Daemon.
```
sudo bash install-nvidia.sh -p
```
### Variable and script
go to ```/opt/env``` to run the rest for the script
```
sudo bash install-scripts.sh
```
