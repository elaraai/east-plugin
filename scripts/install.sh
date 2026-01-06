#!/usr/bin/env bash
# East CLI Installation Script
# Usage: curl -fsSL https://raw.githubusercontent.com/elaraai/east-plugin/main/scripts/install.sh | bash
#
# This script installs the East CLIs for local use without cloning source repositories.
# For development/contributing, use install-dev.sh instead.

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

NODE_VERSION="22"

echo ""
echo "=========================================="
echo "  East CLI Installation"
echo "=========================================="
echo ""
echo "This will install:"
echo "  - nvm (Node Version Manager)"
echo "  - Node.js $NODE_VERSION"
echo "  - @elaraai/east-node-cli (East Node.js CLI)"
echo "  - @elaraai/e3 (East Execution Engine CLI)"
echo "  - uv (Python package manager)"
echo "  - east-py (East Python CLI)"
echo ""

# Check if running interactively
if [ -t 0 ]; then
    read -p "Continue? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi
fi

# Install nvm if not present
install_nvm() {
    if [ -s "$HOME/.nvm/nvm.sh" ]; then
        log_success "nvm already installed"
        return 0
    fi

    log_info "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

    log_success "nvm installed"
}

# Source nvm
source_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}

# Install uv if not present
install_uv() {
    if command -v uv &> /dev/null; then
        log_success "uv already installed"
        return 0
    fi

    log_info "Installing uv (Python package manager)..."
    curl -LsSf https://astral.sh/uv/install.sh | sh

    # Add to PATH for current session
    export PATH="$HOME/.local/bin:$PATH"

    log_success "uv installed"
}

# Install Node.js
install_node() {
    source_nvm

    if ! command -v nvm &> /dev/null; then
        log_error "nvm not found after installation"
        exit 1
    fi

    log_info "Installing Node.js $NODE_VERSION..."
    nvm install "$NODE_VERSION"
    nvm use "$NODE_VERSION"
    nvm alias default "$NODE_VERSION"
    log_success "Node.js $(node --version) installed and set as default"
}

# Install Node.js CLIs
install_node_clis() {
    source_nvm

    log_info "Installing @elaraai/east-node-cli..."
    npm install -g @elaraai/east-node-cli
    log_success "east-node CLI installed"

    log_info "Installing @elaraai/e3..."
    npm install -g @elaraai/e3
    log_success "e3 CLI installed"
}

# Install Python CLI
install_python_cli() {
    if ! command -v uv &> /dev/null; then
        log_error "uv not found"
        return 1
    fi

    log_info "Installing east-py CLI..."

    # Use uv tool to install east-py globally
    # This creates an isolated environment for the CLI
    uv tool install east-py --from git+https://github.com/elaraai/east-py.git

    log_success "east-py CLI installed"
}

# Verify installation
verify_installation() {
    echo ""
    log_info "Verifying installation..."

    local all_good=true

    source_nvm

    if command -v east-node &> /dev/null; then
        log_success "east-node: $(east-node --version 2>/dev/null || echo 'installed')"
    else
        log_warn "east-node not found in PATH"
        all_good=false
    fi

    if command -v e3 &> /dev/null; then
        log_success "e3: $(e3 --version 2>/dev/null || echo 'installed')"
    else
        log_warn "e3 not found in PATH"
        all_good=false
    fi

    if command -v east-py &> /dev/null; then
        log_success "east-py: $(east-py --version 2>/dev/null || echo 'installed')"
    else
        log_warn "east-py not found in PATH"
        all_good=false
    fi

    if [ "$all_good" = true ]; then
        return 0
    else
        return 1
    fi
}

# Print shell configuration instructions
print_shell_config() {
    echo ""
    echo "=========================================="
    echo "  Installation Complete!"
    echo "=========================================="
    echo ""
    echo "Add the following to your shell profile (~/.bashrc, ~/.zshrc, etc.):"
    echo ""
    echo '  # nvm'
    echo '  export NVM_DIR="$HOME/.nvm"'
    echo '  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
    echo ""
    echo '  # uv'
    echo '  export PATH="$HOME/.local/bin:$PATH"'
    echo ""
    echo "Then restart your shell or run:"
    echo '  source ~/.bashrc  # or ~/.zshrc'
    echo ""
    echo "Available commands:"
    echo "  east-node --help   East Node.js CLI"
    echo "  e3 --help          East Execution Engine"
    echo "  east-py --help     East Python CLI"
    echo ""
    echo "Quick start:"
    echo "  mkdir my-project && cd my-project"
    echo "  e3 init"
    echo "  e3 start"
    echo ""
    echo "Documentation: https://github.com/elaraai/east-plugin"
    echo ""
}

# Alternative: Docker installation
print_docker_alternative() {
    echo ""
    echo "=========================================="
    echo "  Alternative: Docker Installation"
    echo "=========================================="
    echo ""
    echo "If you prefer Docker, you can use our pre-built images:"
    echo ""
    echo "  docker pull ghcr.io/elaraai/e3"
    echo "  docker run --rm -v \$(pwd):/workspace ghcr.io/elaraai/e3 e3 --help"
    echo ""
}

# Main installation
main() {
    # Check for curl
    if ! command -v curl &> /dev/null; then
        log_error "curl is required but not installed"
        exit 1
    fi

    # Check for git
    if ! command -v git &> /dev/null; then
        log_error "git is required but not installed"
        exit 1
    fi

    # Install nvm and Node.js
    install_nvm
    install_node

    # Install Node.js CLIs
    install_node_clis

    # Install uv and Python CLI
    install_uv
    install_python_cli || log_warn "Python CLI installation failed (optional)"

    # Verify and print instructions
    if verify_installation; then
        print_shell_config
    else
        log_warn "Some tools may not be in PATH until you restart your shell"
        print_shell_config
        print_docker_alternative
    fi
}

main "$@"
