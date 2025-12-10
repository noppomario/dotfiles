#!/bin/bash

set -e

echo "[INFO] Configuring GNOME applications..."

# GNOME Text Editor
if command -v gnome-text-editor &> /dev/null; then
    gsettings set org.gnome.TextEditor show-line-numbers true
    gsettings set org.gnome.TextEditor highlight-current-line true
    gsettings set org.gnome.TextEditor show-map true
    echo "[INFO] GNOME Text Editor configured"
fi

# GNOME Terminal
if command -v gnome-terminal &> /dev/null; then
    # Get default profile UUID
    profile=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")

    if [ -n "$profile" ]; then
        # Configure cursor style (block is more visible)
        gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ cursor-shape 'block'
        gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ cursor-blink-mode 'on'
        echo "[INFO] GNOME Terminal configured"
    fi
fi

echo "[SUCCESS] GNOME applications configured"
