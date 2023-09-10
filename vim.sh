#!/usr/bin/env bash

if [ "$1" = "build" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo "Successful Build of plug.vim"
elif [ "$1" = "config" ]; then
    if [ -f "$HOME/.vimrc" ]; then
        mv "$HOME/.vimrc" "$HOME/.vimrc.old"
    fi
    cp vim/vimrc "$HOME/.vimrc"

    echo "Successful Configuration!"
else
    echo "USAGE: $0 [build|config]"
    echo "- build : install plug.vim for vim plugins"
    echo "- config: set .vimrc"
fi
