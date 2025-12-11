#!/bin/bash

set -e

echo "[INFO] Setting up Flatpak applications..."

# Check if Flatpak is installed, install if not
if ! command -v flatpak &> /dev/null; then
    echo "[INFO] Flatpak not found, installing..."
    dnf install -y flatpak
    echo "[SUCCESS] Flatpak installed"
fi

# Ensure Flathub repository is available
if ! flatpak remote-list | grep -q flathub; then
    echo "[INFO] Adding Flathub repository..."
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

# Install Extension Manager
if flatpak list | grep -q com.mattjakeman.ExtensionManager; then
    echo "[INFO] Extension Manager is already installed"
else
    echo "[INFO] Installing Extension Manager..."
    flatpak install -y flathub com.mattjakeman.ExtensionManager
    echo "[SUCCESS] Extension Manager installed"
fi

echo "[SUCCESS] Flatpak applications setup completed"
