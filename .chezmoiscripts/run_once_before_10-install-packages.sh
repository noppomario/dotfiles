#!/bin/bash

set -e

echo "[INFO] Installing system packages..."

packages=(
    git
    curl
    unzip
    vim
    fzf
    ripgrep
    fd-find
    zoxide
    ibus-mozc
    gnome-tweaks
)

sudo dnf install -y "${packages[@]}"

echo "[SUCCESS] System packages installed"
