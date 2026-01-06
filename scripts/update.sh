#!/usr/bin/env bash
# East CLI Update Script
# Usage: curl -fsSL https://raw.githubusercontent.com/elaraai/east-plugin/main/scripts/update.sh | bash
#
# Updates all East CLIs to their latest versions from npm/PyPI.

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

echo ""
echo "=========================================="
echo "  East CLI Update"
echo "=========================================="
echo ""

# Source nvm if available
if [ -s "$HOME/.nvm/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"
    \. "$NVM_DIR/nvm.sh"
fi

# Check for npm
if ! command -v npm &> /dev/null; then
    log_error "npm not found. Run install.sh first."
    exit 1
fi

# Update Node.js CLIs
log_info "Updating Node.js packages..."

log_info "Updating @elaraai/east-node-cli..."
npm update -g @elaraai/east-node-cli && log_success "east-node-cli updated" || log_warn "Failed to update east-node-cli"

log_info "Updating @elaraai/e3..."
npm update -g @elaraai/e3 && log_success "e3 updated" || log_warn "Failed to update e3"

log_info "Updating @elaraai/e3-cli..."
npm update -g @elaraai/e3-cli && log_success "e3-cli updated" || log_warn "Failed to update e3-cli"

# Update Python CLI if uv is available
if command -v uv &> /dev/null; then
    log_info "Updating Python packages..."
    uv tool upgrade east-py && log_success "east-py updated" || log_warn "Failed to update east-py"
else
    log_warn "uv not found, skipping Python CLI update"
fi

# Show versions
echo ""
log_info "Current versions:"
echo ""

if command -v east-node &> /dev/null; then
    echo "  east-node: $(east-node --version 2>/dev/null || echo 'unknown')"
fi

if command -v e3 &> /dev/null; then
    echo "  e3: $(e3 --version 2>/dev/null || echo 'unknown')"
fi

if command -v east-py &> /dev/null; then
    echo "  east-py: $(east-py --version 2>/dev/null || echo 'unknown')"
fi

echo ""
log_success "Update complete!"
