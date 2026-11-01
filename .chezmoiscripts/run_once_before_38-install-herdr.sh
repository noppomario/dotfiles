#!/bin/bash

set -e

if command -v herdr-app &> /dev/null || [ -x "$HOME/.local/bin/herdr-app" ]; then
    echo "[INFO] herdr is already installed"
    exit 0
fi

echo "[INFO] Installing herdr via official installer..."
curl -fsSL https://releases.herdr.dev/app/install.sh | sh

echo "[SUCCESS] herdr installed"
