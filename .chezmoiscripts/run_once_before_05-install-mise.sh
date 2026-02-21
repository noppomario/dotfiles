#!/bin/bash

set -e

if command -v mise &> /dev/null; then
    echo "[INFO] mise is already installed"
    exit 0
fi

echo "[INFO] Installing mise..."
curl https://mise.run | sh

echo "[SUCCESS] mise installed"
