#!/bin/bash

set -e

echo "[INFO] Setting up nautilus-open-any-terminal..."

# Install if not already installed
if ! rpm -q nautilus-open-any-terminal &> /dev/null; then
    # Install dnf5-plugins if not already installed (required for copr)
    if ! rpm -q dnf5-plugins &> /dev/null; then
        echo "[INFO] Installing dnf5-plugins..."
        sudo dnf install -y dnf5-plugins
    fi

    # Enable COPR repository
    echo "[INFO] Enabling nautilus-open-any-terminal COPR repository..."
    sudo dnf copr enable -y monkeygold/nautilus-open-any-terminal

    # Install package
    echo "[INFO] Installing nautilus-open-any-terminal from COPR..."
    sudo dnf install -y nautilus-open-any-terminal

    # Restart Nautilus to apply extension
    echo "[INFO] Restarting Nautilus..."
    nautilus -q 2>/dev/null || true
fi

# Configure for Ghostty
echo "[INFO] Configuring nautilus-open-any-terminal for Ghostty..."
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal ghostty
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal new-tab true
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal keybindings '<Ctrl><Alt>t'

echo "[SUCCESS] nautilus-open-any-terminal setup completed"
