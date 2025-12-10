#!/bin/bash

set -e

if command -v code-insiders &> /dev/null; then
    echo "[INFO] VSCode Insiders is already installed"
    exit 0
fi

echo "[INFO] Installing VSCode Insiders..."

# Add Microsoft repository
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo tee /etc/yum.repos.d/vscode-insiders.repo > /dev/null <<'EOF'
[code-insiders]
name=Visual Studio Code Insiders
baseurl=https://packages.microsoft.com/yumrepos/vscode-insiders
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

sudo dnf install -y code-insiders

echo "[SUCCESS] VSCode Insiders installed"
