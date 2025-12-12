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

Test the setup script in a clean container environment:

```bash
cd ~/.local/share/chezmoi
./tests/test-chezmoi.sh
```

See [tests/README.md](tests/README.md) for details.
