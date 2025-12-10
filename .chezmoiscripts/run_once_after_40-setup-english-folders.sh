#!/bin/bash

set -e

echo "[INFO] Converting Japanese folders to English..."

# Check if already converted
if [ ! -d "$HOME/ダウンロード" ] && [ ! -d "$HOME/ドキュメント" ]; then
    echo "[INFO] Folders already converted to English"
    exit 0
fi

# Convert to English folder names
LANG=C xdg-user-dirs-update --force

echo "[SUCCESS] Japanese folders converted to English"
echo "[INFO] Old Japanese folders can be manually deleted if needed"
