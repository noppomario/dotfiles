#!/bin/bash

set -e

# Activate mise
eval "$(mise activate bash)" 2>/dev/null || true

echo "[INFO] Installing development tools via mise..."

# Change to the dotfiles directory to read mise config
if [ -d "$HOME/.local/share/chezmoi" ]; then
    cd "$HOME/.local/share/chezmoi"
fi

mise install

echo "[SUCCESS] All mise tools installed"
echo "[INFO] Installed tools:"
mise list || true
