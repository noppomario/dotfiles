#!/bin/bash

set -e

echo "[INFO] Installing Claude Code..."

# Check if claude is already installed
if command -v claude &> /dev/null; then
    echo "[INFO] Claude Code is already installed (version: $(claude --version 2>/dev/null || echo 'unknown'))"
    echo "[INFO] To upgrade, run: curl -fsSL https://claude.ai/install.sh | bash"
    exit 0
fi

# Install Claude Code using official installer
# The installer is non-interactive and handles all setup automatically
echo "[INFO] Downloading and running official installer..."
curl -fsSL https://claude.ai/install.sh | bash

# Verify installation
if command -v claude &> /dev/null; then
    echo "[SUCCESS] Claude Code installed successfully (version: $(claude --version 2>/dev/null || echo 'unknown'))"
else
    # Check if it was installed to ~/.claude/local/bin
    if [ -x "$HOME/.claude/local/bin/claude" ]; then
        echo "[SUCCESS] Claude Code installed to ~/.claude/local/bin/claude"
        echo "[INFO] You may need to restart your shell or add it to PATH"
    else
        echo "[ERROR] Claude Code installation failed"
        exit 1
    fi
fi
