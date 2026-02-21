#!/bin/bash

set -e

echo "[INFO] Starting Fedora dotfiles setup..."

# Initialize and apply dotfiles using chezmoi
# (bootstrap binary is used once; mise manages chezmoi going forward)
echo "[INFO] Initializing and applying dotfiles..."
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply noppomario/dotfiles

echo "[SUCCESS] Setup completed!"
echo "[INFO] Please restart your shell or run: source ~/.bashrc"
