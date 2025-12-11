#!/bin/bash

set -e

if command -v code-insiders &> /dev/null; then
    echo "[INFO] VSCode Insiders is already installed"
    exit 0
fi

echo "[INFO] Installing VSCode Insiders..."

# Add Microsoft VSCode repository
sudo tee /etc/yum.repos.d/vscode.repo > /dev/null <<EOF
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

# Install VSCode Insiders
sudo dnf install -y code-insiders

echo "[SUCCESS] VSCode Insiders installed"
