#!/bin/bash
# Install rustup components not managed by mise

set -e

export PATH="$HOME/.local/share/mise/shims:$PATH"

if ! command -v rustup &> /dev/null; then
    echo "[INFO] rustup not found, skipping Rust component installation"
    exit 0
fi

echo "[INFO] Installing Rust components via rustup..."
rustup component add rust-analyzer rust-src

echo "[SUCCESS] Rust components installed"
