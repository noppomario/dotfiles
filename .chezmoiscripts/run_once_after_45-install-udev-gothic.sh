#!/bin/bash
# Install UDEV Gothic (Japanese monospace font, used by herdr) from GitHub releases

set -e

FONT_DIR="$HOME/.local/share/fonts/jp-mono"

if fc-list : family | grep -q "UDEV Gothic"; then
    echo "[INFO] UDEV Gothic is already installed"
    exit 0
fi

echo "[INFO] Installing UDEV Gothic..."
url=$(curl -fsSL https://api.github.com/repos/yuru7/udev-gothic/releases/latest |
    grep -oE '"browser_download_url": *"[^"]*/UDEVGothic_v[0-9.]+\.zip"' |
    sed -E 's/.*"(https[^"]+)"/\1/')
[ -n "$url" ] || { echo "[ERROR] UDEV Gothic release asset not found"; exit 1; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
curl -fsSL -o "$tmp/font.zip" "$url"
unzip -q "$tmp/font.zip" -d "$tmp"

mkdir -p "$FONT_DIR"
find "$tmp" -name 'UDEVGothic-*.ttf' -exec cp {} "$FONT_DIR/" \;
fc-cache -f "$FONT_DIR"

echo "[SUCCESS] UDEV Gothic installed"
