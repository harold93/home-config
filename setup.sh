#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

cd ~/
mkdir -p code/pers
cd code/pers
git clone https://github.com/harold93/home-config.git
cd home-config

brew bundle

stow .
