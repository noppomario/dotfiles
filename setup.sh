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

# Install required system packages
install_system_packages() {
    log_info "Installing required system packages..."

    local packages=(
        git
        vim
        curl
        fzf
        'dnf-command(copr)'
    )

    log_info "Installing: ${packages[*]}"
    sudo dnf install -y "${packages[@]}"

    log_success "System packages installed successfully"
}

# Install mise-en-place
install_mise() {
    if command -v mise &> /dev/null; then
        log_success "mise is already installed"
        return 0
    fi

    log_info "Installing mise-en-place..."
    sudo dnf copr enable -y jdxcode/mise
    sudo dnf install -y mise

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

# Install vim-plug
install_vim_plug() {
    local vim_plug_path="$HOME/.vim/autoload/plug.vim"

    if [ -f "$vim_plug_path" ]; then
        log_success "vim-plug is already installed"
        return 0
    fi

    log_info "Installing vim-plug..."
    curl -fLo "$vim_plug_path" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    log_success "vim-plug installed successfully"
}

# Install vim plugins
install_vim_plugins() {
    log_info "Installing vim plugins..."

    # Skip if vimrc doesn't exist or doesn't use vim-plug
    if [ ! -f "$HOME/.vimrc" ]; then
        log_warning "~/.vimrc not found. Skipping vim plugin installation."
        return 0
    fi

    if ! grep -q "plug#begin" "$HOME/.vimrc" 2>/dev/null; then
        log_warning "vim-plug not configured in ~/.vimrc. Skipping plugin installation."
        return 0
    fi

    log_info "Running vim +PlugInstall..."
    vim +PlugInstall +qall || {
        log_warning "vim plugin installation encountered issues. Please run ':PlugInstall' manually in vim."
        return 0
    }

    log_success "Vim plugins installed successfully"
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
    log_info "Starting dotfiles setup for Fedora..."
    echo

    check_fedora
    echo

    install_system_packages
    echo

    install_mise
    echo

    configure_mise_shell
    echo

    install_chezmoi
    echo

    install_vim_plug
    echo

    init_dotfiles
    echo

    apply_dotfiles
    echo

    install_vim_plugins
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
    log_info "  - fzf (for fuzzy file finding)"
    log_info "  - vim with plugins (NERDTree, vim-airline, fzf.vim, vim-code-dark)"
}

# Run main function
main
