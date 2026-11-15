#!/bin/bash
# Install Claude Desktop (official Linux beta) via claude-desktop-rpm.
# The helper installs itself, the launcher, the desktop entry and its daily update timer,
# so none of those files are managed by chezmoi.

set -euo pipefail

echo "[INFO] Installing Claude Desktop..."

if command -v claude-desktop-rpm &> /dev/null; then
    echo "[INFO] Claude Desktop is already installed ($(claude-desktop-rpm version))"
    exit 0
fi

# ar (binutils) unpacks the .deb
command -v ar &> /dev/null || sudo dnf install -y binutils

url=https://github.com/ajithakdev/claude-desktop-rpm/releases/latest/download
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

curl -fsSL -o "$work/claude-desktop-rpm.sh" "$url/claude-desktop-rpm.sh"
curl -fsSL -o "$work/SHA256SUMS" "$url/SHA256SUMS"
(cd "$work" && grep ' claude-desktop-rpm.sh$' SHA256SUMS | sha256sum -c -)

bash "$work/claude-desktop-rpm.sh" install

echo "[SUCCESS] Claude Desktop installed ($(claude-desktop-rpm version))"
