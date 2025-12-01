#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS=$ID
        else
            log_error "Cannot detect Linux distribution"
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    else
        log_error "Unsupported OS: $OSTYPE"
        exit 1
    fi
    log_info "Detected OS: $OS"
}

# Install mise-en-place
install_mise() {
    if command -v mise &> /dev/null; then
        log_success "mise is already installed"
        return 0
    fi

    log_info "Installing mise-en-place..."

    case "$OS" in
        fedora|rhel|centos)
            log_info "Installing mise via dnf (COPR repository)..."
            sudo dnf install -y 'dnf-command(copr)'
            sudo dnf copr enable -y jdxcode/mise
            sudo dnf install -y mise
            ;;
        ubuntu|debian)
            log_info "Installing mise via apt..."
            sudo apt-get update
            sudo apt-get install -y gpg wget curl
            sudo install -dm 755 /etc/apt/keyrings
            wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null
            echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
            sudo apt-get update
            sudo apt-get install -y mise
            ;;
        arch|manjaro)
            log_info "Installing mise via pacman (AUR)..."
            if command -v yay &> /dev/null; then
                yay -S --noconfirm mise-bin
            elif command -v paru &> /dev/null; then
                paru -S --noconfirm mise-bin
            else
                log_error "Please install yay or paru to install mise from AUR"
                exit 1
            fi
            ;;
        macos)
            log_info "Installing mise via Homebrew..."
            if ! command -v brew &> /dev/null; then
                log_error "Homebrew is not installed. Please install it first: https://brew.sh"
                exit 1
            fi
            brew install mise
            ;;
        *)
            log_warning "Unsupported OS for automatic mise installation. Attempting curl install..."
            curl https://mise.run | sh
            ;;
    esac

    log_success "mise installed successfully"
}

# Configure mise in shell
configure_mise_shell() {
    local shell_rc=""

    if [[ -n "$BASH_VERSION" ]]; then
        shell_rc="$HOME/.bashrc"
    elif [[ -n "$ZSH_VERSION" ]]; then
        shell_rc="$HOME/.zshrc"
    else
        shell_rc="$HOME/.bashrc"
    fi

    if grep -q 'mise activate' "$shell_rc" 2>/dev/null; then
        log_success "mise is already configured in $shell_rc"
        return 0
    fi

    log_info "Configuring mise in $shell_rc..."

    echo '' >> "$shell_rc"
    echo '# mise-en-place activation' >> "$shell_rc"

    if [[ -n "$BASH_VERSION" ]] || [[ "$shell_rc" == *"bashrc"* ]]; then
        echo 'eval "$(mise activate bash)"' >> "$shell_rc"
    elif [[ -n "$ZSH_VERSION" ]] || [[ "$shell_rc" == *"zshrc"* ]]; then
        echo 'eval "$(mise activate zsh)"' >> "$shell_rc"
    fi

    log_success "mise configured in $shell_rc"
    log_warning "Please run 'source $shell_rc' or restart your shell to activate mise"
}

# Install chezmoi via mise
install_chezmoi() {
    # Activate mise in current shell
    eval "$(mise activate bash)" 2>/dev/null || true

    if command -v chezmoi &> /dev/null; then
        log_success "chezmoi is already installed"
        return 0
    fi

    log_info "Installing chezmoi via mise..."
    mise use -g chezmoi@latest

    # Verify installation
    eval "$(mise activate bash)" 2>/dev/null || true
    if ! command -v chezmoi &> /dev/null; then
        log_error "chezmoi installation failed"
        exit 1
    fi

    log_success "chezmoi installed successfully"
}

# Initialize dotfiles with chezmoi
init_dotfiles() {
    eval "$(mise activate bash)" 2>/dev/null || true

    local repo_url="https://github.com/noppomario/dotfiles.git"

    if [ -d "$HOME/.local/share/chezmoi" ]; then
        log_warning "chezmoi is already initialized. Skipping init..."
        return 0
    fi

    log_info "Initializing dotfiles from $repo_url..."
    chezmoi init "$repo_url"

    log_success "Dotfiles initialized"
}

# Apply dotfiles
apply_dotfiles() {
    eval "$(mise activate bash)" 2>/dev/null || true

    log_info "Applying dotfiles..."

    # Show diff before applying
    log_info "Changes that will be applied:"
    chezmoi diff || true

    # Ask for confirmation
    read -p "Do you want to apply these changes? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        chezmoi apply
        log_success "Dotfiles applied successfully"
    else
        log_warning "Skipping dotfiles application"
        return 0
    fi
}

# Install tools via mise
install_tools() {
    eval "$(mise activate bash)" 2>/dev/null || true

    log_info "Installing tools via mise..."

    # Change to the dotfiles directory to read mise config
    if [ -d "$HOME/.local/share/chezmoi" ]; then
        cd "$HOME/.local/share/chezmoi"
    fi

    mise install

    log_success "All tools installed successfully"
}

# Display installed tools
show_installed_tools() {
    eval "$(mise activate bash)" 2>/dev/null || true

    log_info "Installed tools:"
    mise list || true
}

# Main setup function
main() {
    log_info "Starting dotfiles setup..."
    echo

    detect_os
    echo

    install_mise
    echo

    configure_mise_shell
    echo

    install_chezmoi
    echo

    init_dotfiles
    echo

    apply_dotfiles
    echo

    install_tools
    echo

    show_installed_tools
    echo

    log_success "Setup completed successfully!"
    echo
    log_info "Please restart your shell or run: source ~/.bashrc"
    log_info "Then you can use the following tools:"
    log_info "  - node, pnpm (for JavaScript/TypeScript development)"
    log_info "  - python, uv (for Python development)"
    log_info "  - claude-code (Anthropic's Claude CLI)"
    log_info "  - chezmoi (for managing dotfiles)"
}

# Run main function
main
