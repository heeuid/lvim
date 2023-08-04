#!/usr/bin/env bash

if [ "$1" = "build" ]; then
    # For neovim
    sudo apt-get install ninja-build gettext cmake unzip curl
    git clone https://github.com/neovim/neovim
    cd neovim
    git switch release-0.9
    make CMAKE_BUILD_TYPE=RelWithDebInfo # permission error occurs, then use 'sudo'
    sudo make install
    cd -
    rm -rf neovim

    # For lunarvim configuration
    LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
elif [ "$1" = "config" ]; then
    if [ -f "~/.config/lvim" ]; then
        mv ~/.config/lvim ~/.config/lvim.old
    fi

    if [ -d "lvim" ]; then
        mv lvim ~/.config
    elif [ -f "lvim.tar.xz" ]; then
        tar -xf lvim.tar.xz
        mv lvim ~/.config
    else
        git clone https://github.com/heeuid/lvim
        cd lvim
        mv lvim ~/.config
        cd -
        rm -rf lvim
    fi
fi
