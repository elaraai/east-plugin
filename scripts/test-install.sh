#!/usr/bin/env bash
# Test installation scripts in a fresh Ubuntu container
# Usage: ./test-install.sh [install|install-dev]

set -e

SCRIPT="${1:-install}"
BRANCH="${2:-main}"

echo "Testing scripts/$SCRIPT.sh in fresh Ubuntu container..."
echo ""

# For local testing, mount the current directory
if [ -f "scripts/$SCRIPT.sh" ]; then
    echo "Using local script from ./scripts/$SCRIPT.sh"
    docker run -it --rm \
        -v "$(pwd)/scripts:/scripts:ro" \
        ubuntu:24.04 \
        bash -c "
            apt-get update && apt-get install -y curl git
            bash /scripts/$SCRIPT.sh
        "
else
    echo "Fetching script from GitHub (branch: $BRANCH)"
    docker run -it --rm \
        ubuntu:24.04 \
        bash -c "
            apt-get update && apt-get install -y curl git
            curl -fsSL https://raw.githubusercontent.com/elaraai/east-plugin/$BRANCH/scripts/$SCRIPT.sh | bash
        "
fi
