#!/bin/bash

set -e

if command -v google-chrome &> /dev/null; then
    echo "[INFO] Google Chrome is already installed"
    exit 0
fi

echo "[INFO] Installing Google Chrome..."

# Add Google Chrome repository
sudo tee /etc/yum.repos.d/google-chrome.repo > /dev/null <<'EOF'
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF

sudo dnf install -y google-chrome-stable

echo "[SUCCESS] Google Chrome installed"
