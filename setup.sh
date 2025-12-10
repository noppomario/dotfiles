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

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on Fedora
check_fedora() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "$ID" != "fedora" ]]; then
            log_error "This script is designed for Fedora only. Detected OS: $ID"
            exit 1
        fi
        log_info "Detected Fedora $VERSION_ID"
    else
        log_error "Cannot detect OS. /etc/os-release not found."
        exit 1
    fi
}

# Install minimal prerequisites
install_prerequisites() {
    log_info "Installing minimal prerequisites (git, curl)..."

    # Check if already installed
    local to_install=()
    command -v git &> /dev/null || to_install+=(git)
    command -v curl &> /dev/null || to_install+=(curl)

    if [ ${#to_install[@]} -eq 0 ]; then
        log_success "Prerequisites already installed"
        return 0
    fi

    sudo dnf install -y "${to_install[@]}"
    log_success "Prerequisites installed successfully"
}

# Install mise-en-place
install_mise() {
    if command -v mise &> /dev/null; then
        log_success "mise is already installed"
        return 0
    fi

    log_info "Installing mise-en-place..."

    # Install dnf-plugins-core if not present
    if ! dnf copr --help &> /dev/null 2>&1; then
        sudo dnf install -y 'dnf-command(copr)'
    fi

    sudo dnf copr enable -y jdxcode/mise
    sudo dnf install -y mise

    log_success "mise installed successfully"
}

# Configure mise in shell
configure_mise_shell() {
    local shell_rc="$HOME/.bashrc"

    if grep -q 'mise activate' "$shell_rc" 2>/dev/null; then
        log_success "mise is already configured in $shell_rc"
        return 0
    fi

    log_info "Configuring mise in $shell_rc..."

    echo '' >> "$shell_rc"
    echo '# mise-en-place activation' >> "$shell_rc"
    echo 'eval "$(mise activate bash)"' >> "$shell_rc"

    log_success "mise configured in $shell_rc"
}

# Install chezmoi via mise
install_chezmoi() {
    if command -v chezmoi &> /dev/null; then
        log_success "chezmoi is already installed"
        return 0
    fi

    log_info "Installing chezmoi via mise..."
    mise use -g chezmoi@latest

    # Verify installation
    if ! command -v chezmoi &> /dev/null; then
        log_error "chezmoi installation failed"
        exit 1
    fi

    log_success "chezmoi installed successfully"
}

# Initialize dotfiles with chezmoi
init_dotfiles() {
    local repo_url="https://github.com/noppomario/dotfiles.git"

    if [ -d "$HOME/.local/share/chezmoi" ]; then
        log_success "chezmoi is already initialized"
        return 0
    fi

    log_info "Initializing dotfiles from $repo_url..."
    chezmoi init "$repo_url"

    log_success "Dotfiles initialized"
}

# Apply dotfiles
apply_dotfiles() {
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
        log_info "chezmoi will now run setup scripts..."
    else
        log_error "Setup cancelled by user"
        exit 1
    fi
}

# Main setup function
main() {
    log_info "Starting Fedora dotfiles setup..."
    echo

    check_fedora
    echo

    install_prerequisites
    echo

    install_mise
    echo

    configure_mise_shell
    echo

    # Activate mise for current shell session
    eval "$(mise activate bash)" 2>/dev/null || true
    echo

    install_chezmoi
    echo

    init_dotfiles
    echo

    apply_dotfiles
    echo

    log_success "Bootstrap completed successfully!"
    echo
    log_info "Please restart your shell or run: source ~/.bashrc"
    log_info "All packages and applications have been installed via chezmoi scripts."
}

# Run main function
main
