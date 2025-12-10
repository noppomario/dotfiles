#!/bin/bash

set -e

if command -v onedrive &> /dev/null; then
    echo "[INFO] OneDrive is already installed"
    exit 0
fi

echo "[INFO] Installing OneDrive..."

sudo dnf install -y onedrive

# Enable service for automatic start on boot (but don't start yet)
systemctl --user enable onedrive.service

echo "[SUCCESS] OneDrive installed and service enabled"
echo "[INFO] To set up OneDrive:"
echo "  1. Run: onedrive"
echo "  2. Follow authentication prompts"
echo "  3. Run: systemctl --user start onedrive.service"
echo "  (Service will auto-start on next boot)"
