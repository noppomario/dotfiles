#!/bin/bash

set -e

echo "[INFO] Configuring keyboard shortcuts..."

# Workspace switching
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Super>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Super>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Control><Super>Up']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last "['<Control><Super>Down']"

# Screenshot
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Super><Shift>s']"

# Show desktop (minimize all windows)
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"

# Screen lock
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Control><Alt>l']"

echo "[SUCCESS] Keyboard shortcuts configured"
