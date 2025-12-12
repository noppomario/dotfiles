#!/bin/bash
#
# TEST SCRIPT - NOT FOR PRODUCTION USE
# Purpose: Test the dotfiles setup.sh script in a clean container environment
# This file is excluded from chezmoi deployment via .chezmoiignore
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[TEST]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[TEST SUCCESS]${NC} $1"
}

log_error() {
    echo -e "${RED}[TEST ERROR]${NC} $1"
}

# Get script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Configuration
IMAGE_NAME="dotfiles-test"
CONTAINER_NAME="dotfiles-test-$(date +%s)"

log_info "Dotfiles Testing Environment"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
log_info "Project root: $PROJECT_ROOT"
log_info "Using Podman (optimized for Podman)"
echo

# Check if podman is available
if ! command -v podman &> /dev/null; then
    log_error "Podman is not installed. Please install podman first."
    exit 1
fi

# Build test image
log_info "Building test image from Containerfile..."
podman build -t "$IMAGE_NAME" -f "$SCRIPT_DIR/Containerfile" "$SCRIPT_DIR"

if [ $? -eq 0 ]; then
    log_success "Test image built successfully"
else
    log_error "Failed to build test image"
    exit 1
fi

echo
log_info "Starting test container..."
log_info "Container will:"
log_info "  1. Mount setup.sh from: $PROJECT_ROOT/setup.sh"
log_info "  2. Run setup.sh as testuser with sudo privileges"
log_info "  3. Drop into interactive bash for manual verification"
echo
log_info "Press Ctrl+D or type 'exit' to quit the container when done"
echo

# Run container with setup.sh mounted
# Using --rm for auto-cleanup
# Using --privileged for systemd and full functionality
# Mounting setup.sh as read-only to prevent accidental modifications
podman run -it --rm \
  --name "$CONTAINER_NAME" \
  --privileged \
  --network host \
  -v "$PROJECT_ROOT/setup.sh:/home/testuser/setup.sh:ro" \
  -e CI=true \
  "$IMAGE_NAME" bash -c "
    echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
    echo 'Test Environment Ready'
    echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
    echo
    echo 'Running setup.sh in test mode (CI=true)...'
    echo
    bash /home/testuser/setup.sh
    echo
    echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
    echo 'Setup completed. Dropping into interactive shell.'
    echo 'You can now verify the installation manually.'
    echo 'Type exit or press Ctrl+D to quit.'
    echo '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
    echo
    exec bash
  "

echo
log_success "Test container exited"
log_info "Container was automatically removed (--rm flag)"
