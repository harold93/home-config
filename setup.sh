#!/bin/bash

# ssh key generation if doesn't exist
[ -f ~/.ssh/id_ed25519 ] || ssh-keygen -t ed25519

sudo dnf install -y git
cd ~/
mkdir -p code/pers
cd ~/code/pers
git clone -b linux https://github.com/harold93/home-config.git
cd ~/code/pers/home-config

######## Enable dnf features
sudo dnf install dnf-plugins-core

######## Install third-party (but trusted) repo
sudo dnf install fedora-workstation-repositories

######## Add docker official repo 
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
 https://download.docker.com/linux/fedora/docker-ce.repo

######## Add repo vscode
sudo dnf config-manager addrepo --from-repofile=https://packages.microsoft.com/yumrepos/vscode/config.repo
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.34/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.34/rpm/repodata/repomd.xml.key
EOF

######## Add repo temurin
cat <<EOF | sudo tee /etc/yum.repos.d/adoptium.repo
[Adoptium]
name=Adoptium
baseurl=https://packages.adoptium.net/artifactory/rpm/fedora/\$releasever/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.adoptium.net/artifactory/api/gpg/key/public
EOF

######## With dnf we can no longer enable third-party repo via dnf, so we do it manually
sudo sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/google-chrome.repo
sudo sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/docker-ce.repo 

######## COPR (Cool Other Package Repositories) system, which hosts community-maintained packages.
# enable sneexy copr repo zen browser
sudo dnf copr enable sneexy/zen-browser
# slack copr
sudo dnf copr enable rocketraman/slack-repo
# download slack repository in /etc/yum.repos.d/
sudo dnf install slack-repo
# xremap to remap keyboard
sudo dnf copr enable blakegardner/xremap
# Some bins like eza, lazygit, yazi etc
sudo dnf copr enable nclundell/fedora-extras
# chruby
sudo dnf copr enable duritong/chruby
# kubectx
sudo dnf copr enable buckaroogeek/k8s-utils

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
# to dump the file: dnf repoquery --installed --qf "%{name}\n" > packages-list.txt
sudo dnf update
sudo dnf install $(< packages-list.txt)

######## Install Flatpack
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

######## Apply dotfiles
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
stow .

####### After deps Install
# docker sudoless
sudo systemctl enable docker
sudo systemctl start docker
sudo groupadd docker || echo 'docker group already exist'
sudo usermod -aG docker $USER
newgrp docker
# tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.config/tmux/tmux.conf
# ruby
# FIXME: 404 error
ruby-install ruby 3.4.1
# toolbox jetbrains
# TODO: curl toolbox app and run it 

