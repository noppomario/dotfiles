#!/bin/bash

set -e

if ! command -v onedrive &> /dev/null; then
    echo "[INFO] OneDrive not installed, skipping service setup"
    exit 0
fi

echo "[INFO] Setting up OneDrive systemd service..."

# Check if OneDrive has been authenticated
if [ ! -f "$HOME/.config/onedrive/refresh_token" ]; then
    echo "[WARNING] OneDrive not authenticated yet"
    echo "[WARNING] Please run 'onedrive' to authenticate before the service can work"
    echo "[INFO] Service will be enabled but not started"

    # Enable service for future use
    systemctl --user enable onedrive.service

    echo "[INFO] After authentication, run: systemctl --user start onedrive.service"
    exit 0
fi

# OneDrive is authenticated, enable and start service
systemctl --user enable onedrive.service
systemctl --user start onedrive.service

echo "[SUCCESS] OneDrive service enabled and started"
