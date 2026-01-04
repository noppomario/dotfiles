#!/bin/bash

set -e

echo "[INFO] Installing Ghostty..."

# Check if ghostty is already installed
if command -v ghostty &> /dev/null; then
    echo "[INFO] Ghostty is already installed (version: $(ghostty --version))"
    exit 0
fi

# Install dnf5-plugins if not already installed (required for copr)
if ! rpm -q dnf5-plugins &> /dev/null; then
    echo "[INFO] Installing dnf5-plugins..."
    sudo dnf install -y dnf5-plugins
fi

# Enable COPR repository for Ghostty
echo "[INFO] Enabling Ghostty COPR repository..."
sudo dnf copr enable -y scottames/ghostty

# Install Ghostty
echo "[INFO] Installing Ghostty from COPR..."
sudo dnf install -y ghostty

# Verify installation
if command -v ghostty &> /dev/null; then
    echo "[SUCCESS] Ghostty installed successfully (version: $(ghostty --version))"
else
    echo "[ERROR] Ghostty installation failed"
    exit 1
fi
