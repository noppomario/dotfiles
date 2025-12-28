#!/bin/bash

set -e

echo "[INFO] Installing GitHub CLI (gh)..."

# Check if gh is already installed
if command -v gh &> /dev/null; then
    echo "[INFO] GitHub CLI is already installed (version: $(gh --version | head -n1))"
    exit 0
fi

# Install dnf5-plugins if not already installed
if ! rpm -q dnf5-plugins &> /dev/null; then
    echo "[INFO] Installing dnf5-plugins..."
    sudo dnf install -y dnf5-plugins
fi

# Add GitHub CLI repository
echo "[INFO] Adding GitHub CLI repository..."
sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo

# Install GitHub CLI
echo "[INFO] Installing gh from gh-cli repository..."
sudo dnf install -y gh --repo gh-cli

# Verify installation
if command -v gh &> /dev/null; then
    echo "[SUCCESS] GitHub CLI installed successfully (version: $(gh --version | head -n1))"
else
    echo "[ERROR] GitHub CLI installation failed"
    exit 1
fi
