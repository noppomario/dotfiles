#!/bin/bash

set -e

vim_plug_path="$HOME/.vim/autoload/plug.vim"

if [ -f "$vim_plug_path" ]; then
    echo "[INFO] vim-plug is already installed"
    exit 0
fi

echo "[INFO] Installing vim-plug..."

curl -fLo "$vim_plug_path" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "[SUCCESS] vim-plug installed"
