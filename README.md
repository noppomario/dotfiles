# dotfiles

## Quick Setup (Recommended)

Run the automated setup script:

```bash
curl -fsSL https://raw.githubusercontent.com/noppomario/dotfiles/main/setup.sh | bash
```

Or clone and run locally:

```bash
git clone https://github.com/noppomario/dotfiles.git
cd dotfiles
./setup.sh
```

The setup script will:
1. Install mise-en-place (tool version manager)
2. Install chezmoi (dotfile manager)
3. Clone this dotfiles repository
4. Apply dotfiles to your system
5. Install all required tools (node, pnpm, python, uv, claude-code, etc.)

### Supported Operating Systems

- Fedora/RHEL/CentOS
- Ubuntu/Debian
- Arch Linux/Manjaro
- macOS (requires Homebrew)

## Manual Setup

If you prefer to set up manually:

### 1. Install mise-en-place

**Fedora/RHEL:**
```bash
sudo dnf copr enable jdxcode/mise
sudo dnf install mise
echo 'eval "$(mise activate bash)"' >> ~/.bashrc
```

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install -y gpg wget curl
sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
sudo apt-get update
sudo apt-get install -y mise
echo 'eval "$(mise activate bash)"' >> ~/.bashrc
```

**macOS:**
```bash
brew install mise
echo 'eval "$(mise activate bash)"' >> ~/.bashrc
```

### 2. Clone dotfiles

```bash
chezmoi init https://github.com/noppomario/dotfiles.git
```

### 3. Apply dotfiles

```bash
chezmoi apply
mise install
```

## Installed Tools

After setup, the following tools will be available:

- **chezmoi** - Dotfile manager
- **node** - JavaScript runtime (latest)
- **pnpm** - Fast, disk space efficient package manager
- **python** - Python interpreter (latest)
- **uv** - Ultra-fast Python package installer
- **claude-code** - Anthropic's Claude CLI for AI-assisted coding
