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

    echo "Successful Build & Instal!"

    # For lunarvim configuration
    LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
elif [ "$1" = "config" ]; then
    if [ -d "$HOME/.config/lvim" ]; then
        if [ -d "$HOME/.config/lvim.old" ]; then
            rm -rf $HOME/.config/lvim.old
        fi
        mv $HOME/.config/lvim $HOME/.config/lvim.old
    fi

    if [ -d "lvim" ]; then
        cp -r lvim $HOME/.config
    elif [ -f "lvim.tar.xz" ]; then
        tar -xf lvim.tar.xz
        mv lvim $HOME/.config
    else
        git clone https://github.com/heeuid/lvim
        cd lvim
        mv lvim $HOME/.config
        cd -
        rm -rf lvim
    fi

    echo "Successful Configuration!"
fi
