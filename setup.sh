#!/bin/bash

# ssh key generation if doesn't exist
[ -f ~/.ssh/id_ed25519 ] || ssh-keygen -t ed25519

sudo dnf install -y git
cd ~/
mkdir -p code/pers
cd ~/code/pers
git clone -b macbook https://github.com/harold93/home-config.git
cd ~/code/pers/home-config

######## Enable dnf features
sudo dnf install dnf-plugins-core

######## Install third-party (but trusted) repo
sudo dnf install fedora-workstation-repositories

######## With dnf we can no longer enable third-party repo via dnf, so we do it manually
sudo sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/google-chrome.repo

######## COPR (Cool Other Package Repositories) system, which hosts community-maintained packages.
# enable sneexy copr repo zen browser
sudo dnf copr enable sneexy/zen-browser
# slack copr
sudo dnf copr enable rocketraman/slack-repo
sudo dnf install slack-repo
# xremap to remap keyboard
sudo dnf copr enable blakegardner/xremap

######## Enable xremap to run without sudo
# add to group input
sudo gpasswd -a $USER input
# create udev rule to allows user-level access to the uinput device
echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules
# load uinput module
sudo modprobe uinput
# reload udev rules
sudo udevadm control --reload-rules
# ensure it loads automatically on boot
echo "uinput" | sudo tee -a /etc/modules-load.d/uinput.conf
echo 'Xremap without sudo settled, you may need to reboot'


######## Install dump file


######## Apply dotfiles
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
stow .
