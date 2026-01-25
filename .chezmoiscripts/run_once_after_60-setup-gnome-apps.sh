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

echo "[SUCCESS] GNOME applications configured"
