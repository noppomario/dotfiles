#!/bin/bash

set -e

echo "[INFO] Configuring ibus-mozc key bindings..."

# Configure Henkan (変換) key for IME ON
# Configure Muhenkan (無変換) key for IME OFF
gsettings set org.freedesktop.ibus.general.hotkey triggers "['Henkan', 'Muhenkan']"

# Set up engine switching
gsettings set org.freedesktop.ibus.general.hotkey switch-engine "['<Super>space']"

# Configure Mozc-specific settings if available
if gsettings list-schemas | grep -q org.freedesktop.ibus.engine.mozc; then
    # Enable composition mode for better Japanese input
    gsettings set org.freedesktop.ibus.engine.mozc composition-mode 'HIRAGANA' 2>/dev/null || true
fi

echo "[SUCCESS] ibus-mozc configured"
echo "[INFO] Henkan (変換) key: Switch to Japanese input"
echo "[INFO] Muhenkan (無変換) key: Switch to direct input"
