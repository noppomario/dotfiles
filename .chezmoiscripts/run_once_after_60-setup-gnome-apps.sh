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

# Ptyxis Terminal (Fedora 41+)
if command -v ptyxis &> /dev/null; then
    # Get default profile ID
    profile=$(gsettings get org.gnome.Ptyxis default-profile-uuid 2>/dev/null | tr -d "'")

    if [ -n "$profile" ] && [ "$profile" != "" ]; then
        # Configure cursor settings
        gsettings set org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/$profile/ cursor-blink-mode 'on' 2>/dev/null || true
        gsettings set org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/$profile/ cursor-shape 'block' 2>/dev/null || true
        echo "[INFO] Ptyxis terminal configured"
    fi
fi

# GNOME Terminal (fallback for older Fedora)
if command -v gnome-terminal &> /dev/null; then
    # Get default profile UUID
    profile=$(gsettings get org.gnome.Terminal.ProfilesList default 2>/dev/null | tr -d "'")

    if [ -n "$profile" ]; then
        # Configure cursor style (block is more visible)
        gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ cursor-shape 'block' 2>/dev/null || true
        gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ cursor-blink-mode 'on' 2>/dev/null || true
        echo "[INFO] GNOME Terminal configured"
    fi
fi

echo "[SUCCESS] GNOME applications configured"
