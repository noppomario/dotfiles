#!/bin/bash

set -e

# Fallback: install mise if not present (normally installed by before_05)
if ! command -v mise &> /dev/null; then
    echo "[INFO] Installing mise..."
    curl https://mise.run | sh
    export PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$HOME/.local/share/mise/shims:$PATH"

echo "[INFO] Installing development tools via mise..."
mise install

echo "[SUCCESS] All mise tools installed"
echo "[INFO] Installed tools:"
mise list || true
