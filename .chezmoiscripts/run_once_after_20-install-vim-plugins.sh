#!/bin/bash

set -e

if [ ! -f "$HOME/.vimrc" ]; then
    echo "[WARNING] ~/.vimrc not found. Skipping vim plugin installation."
    exit 0
fi

if ! grep -q "plug#begin" "$HOME/.vimrc" 2>/dev/null; then
    echo "[WARNING] vim-plug not configured in ~/.vimrc. Skipping plugin installation."
    exit 0
fi

echo "[INFO] Installing vim plugins..."

vim +PlugInstall +qall || {
    echo "[WARNING] vim plugin installation encountered issues. Please run ':PlugInstall' manually in vim."
    exit 0
}

echo "[SUCCESS] Vim plugins installed"
