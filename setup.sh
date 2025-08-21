#!/bin/bash

# ssh key generation if doesn't exist
[ -f ~/.ssh/id_ed25519 ] || ssh-keygen -t ed25519

# we install git in order to be able to install ohmyzsh
brew install git

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

cd ~/
mkdir -p code/pers
cd ~/code/pers
git clone -b macbook https://github.com/harold93/home-config.git
cd ~/code/pers/home-config

brew bundle

mv ~/.zshrc ~/.zshrc.bak
stow .

# to be compatible with aerospace, we need these settings
defaults write com.apple.dock expose-group-apps -bool true && killall Dock
defaults write com.apple.spaces spans-displays -bool true && killall SystemUIServer

# run these apps at least once, to setup settings rights
open -a Karabiner-Elements
open -a AeroSpace

# install a new version of ruby
ruby-install ruby 3.4.1
