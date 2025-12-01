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
