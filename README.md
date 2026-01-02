# dotfiles

Personal dotfiles for Fedora Linux

## Notes

- This setup is for Fedora Linux only.
- Administrator privileges are required.
- A stable internet connection is required.

## Setup

### 1. Create config file (before running setup.sh)

```bash
mkdir -p ~/.config/chezmoi
cat > ~/.config/chezmoi/chezmoi.toml << 'EOF'
[data]
  ntfy_topic = "your-ntfy-topic"
EOF
```

| Variable     | Used in                            | Description        |
| ------------ | ---------------------------------- | ------------------ |
| `ntfy_topic` | `dot_claude/hooks/smart-notify.sh` | ntfy.sh topic name |

### 2. Run setup script

```bash
sudo dnf install -y curl
curl -fsSL \
  https://raw.githubusercontent.com/noppomario/dotfiles/main/setup.sh | bash
```

## Post-Setup Steps

### OneDrive Setup

After installation, manually configure OneDrive:

1. Run: `onedrive`
2. Follow the authentication prompts
3. Run: `mkdir -p ~/OneDrive`
4. Run: `onedrive --sync`
5. Run: `systemctl --user start onedrive.service` (will auto-start on next boot)

### English Folders

Japanese folders are automatically converted to English. Old Japanese folders can
be manually deleted if needed.

## Testing

```bash
cd ~/.local/share/chezmoi
bash ./test-chezmoi.sh
```

## Cheat Sheet

### chezmoi

```bash
# Edit files through chezmoi
chezmoi edit .bashrc

# Re-add directly edited files
chezmoi add .config/mise/config.toml

# Re-add All diff files
chezmoi diff
chezmoi re-add
```

### mise

```bash
# Add new dependency (install and use immediately / latest version)
mise use -g go
```

```bash
# For go install
mise use -g go:github.com/wailsapp/wails/v2/cmd/wails@latest

# For npm install
mise use -g npm:prettier

# For **uv** install
mise use -g pipx:<tool>
```

> **Note:** After making these changes, always run:
>
> ```bash
> chezmoi re-add
> ```

### bash alias

```bash
# Reload shortcut
brc
```
