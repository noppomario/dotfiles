#!/bin/bash

set -e

echo "[INFO] Starting Fedora dotfiles setup..."

# Install chezmoi using Fedora package
if ! command -v chezmoi &> /dev/null; then
    echo "[INFO] Installing chezmoi..."
    sudo dnf install -y chezmoi
fi

# Initialize and apply dotfiles
echo "[INFO] Initializing and applying dotfiles..."
chezmoi init --apply noppomario/dotfiles

echo "[SUCCESS] Setup completed!"
echo "[INFO] Please restart your shell or run: source ~/.bashrc"
