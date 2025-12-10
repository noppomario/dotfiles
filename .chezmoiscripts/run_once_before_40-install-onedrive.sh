#!/bin/bash

set -e

if command -v onedrive &> /dev/null; then
    echo "[INFO] OneDrive is already installed"
    exit 0
fi

echo "[INFO] Installing OneDrive..."

sudo dnf install -y onedrive

echo "[SUCCESS] OneDrive installed"
echo "[WARNING] Run 'onedrive' to complete authentication and setup"
