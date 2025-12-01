# dotfiles

Personal dotfiles for Fedora Linux

## Quick Setup (Recommended)

**Requirements:** Fedora Linux

### Step 1: Install basic requirements

```bash
sudo dnf install -y git curl
```

### Step 2: Run the automated setup script

Option A - Download and run directly:
```bash
curl -fsSL https://raw.githubusercontent.com/noppomario/dotfiles/main/setup.sh | bash
```

Option B - Clone and run locally:
```bash
git clone https://github.com/noppomario/dotfiles.git
cd dotfiles
./setup.sh
```

The setup script will:
1. Check if running on Fedora (will exit if not)
2. Install additional system packages (vim, fzf, dnf-plugins-core)
3. Install mise-en-place (tool version manager)
4. Install chezmoi (dotfile manager) via mise
5. Install vim-plug (vim plugin manager)
6. Clone this dotfiles repository
7. Apply dotfiles to your system (with confirmation)
8. Install vim plugins (NERDTree, vim-airline, fzf.vim, vim-code-dark)
9. Install development tools via mise (node, pnpm, python, uv, claude-code)

## Manual Setup

If you prefer to set up manually on Fedora:

### 1. Install basic requirements

```bash
sudo dnf install -y git curl
```

### 2. Install additional system packages

```bash
sudo dnf install -y vim fzf dnf-plugins-core
```

### 3. Install mise-en-place

```bash
sudo dnf copr enable jdxcode/mise
sudo dnf install mise
echo 'eval "$(mise activate bash)"' >> ~/.bashrc
source ~/.bashrc
```

### 4. Install vim-plug

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### 5. Initialize and apply dotfiles

```bash
mise use -g chezmoi@latest
chezmoi init https://github.com/noppomario/dotfiles.git
chezmoi apply
```

### 6. Install vim plugins

```bash
vim +PlugInstall +qall
```

### 7. Install development tools

```bash
mise install
```

## Installed Tools

After setup, the following tools will be available:

### System Tools
- **git** - Version control
- **vim** - Text editor with plugins
- **curl** - HTTP client
- **fzf** - Fuzzy finder for files and commands

### Vim Plugins (via vim-plug)
- **NERDTree** - File tree explorer
- **vim-airline** - Status bar
- **fzf.vim** - Fuzzy file search
- **vim-code-dark** - VS Code dark theme

### Development Tools (via mise)
- **chezmoi** - Dotfile manager
- **node** - JavaScript runtime (latest)
- **pnpm** - Fast, disk space efficient package manager
- **python** - Python interpreter (latest)
- **uv** - Ultra-fast Python package installer
- **claude-code** - Anthropic's Claude CLI for AI-assisted coding
