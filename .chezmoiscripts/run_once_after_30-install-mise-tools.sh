#!/bin/bash

set -e

# Install mise if not present
if ! command -v mise &> /dev/null; then
    echo "[INFO] Installing mise..."
    curl https://mise.run | sh
    export PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$HOME/.local/share/mise/shims:$PATH"

echo "[INFO] Installing development tools via mise..."

# Change to the dotfiles directory to read mise config
if [ -d "$HOME/.local/share/chezmoi" ]; then
    cd "$HOME/.local/share/chezmoi"
fi

mise install

echo "[SUCCESS] All mise tools installed"
echo "[INFO] Installed tools:"
mise list || true
