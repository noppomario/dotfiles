#!/bin/bash

set -e

echo "[INFO] Installing system packages..."

packages=(
    vim
    fzf
    ripgrep
    fd-find
    ibus-mozc
    gnome-tweaks
)

sudo dnf install -y "${packages[@]}"

echo "[SUCCESS] System packages installed"
