#!/bin/bash

set -e

echo "[INFO] Installing uti..."

# Check if uti is already installed
if command -v uti &> /dev/null; then
    echo "[INFO] uti is already installed (version: $(uti --version 2>/dev/null || echo 'unknown'))"
    exit 0
fi

# Install uti using official installer
echo "[INFO] Downloading and running official installer..."
curl -fsSL https://raw.githubusercontent.com/noppomario/uti/main/install.sh | bash

# Verify installation
if command -v uti &> /dev/null; then
    echo "[SUCCESS] uti installed successfully (version: $(uti --version 2>/dev/null || echo 'unknown'))"
else
    echo "[ERROR] uti installation failed"
    exit 1
fi

echo "[NOTE] See README.md for post-setup steps (logout required)"
