# dotfiles

Personal dotfiles for Fedora Linux

## Notes

- This setup is for Fedora Linux only.
- Administrator privileges are required.
- A stable internet connection is required.

## Setup

```bash
sudo dnf install -y curl
curl -fsSL https://raw.githubusercontent.com/noppomario/dotfiles/main/setup.sh | bash
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

Japanese folders are automatically converted to English. Old Japanese folders can be manually deleted if needed.

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
```

> **Note:** After making these changes, always run:
>
> ```bash
> chezmoi add .config/mise/config.toml
> ```

### bash alias

```bash
# Reload shortcut
brc
```
