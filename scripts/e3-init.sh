#!/usr/bin/env bash
# e3 init script - uses local e3 if available, falls back to Docker
set -e

if command -v e3 &> /dev/null; then
    e3 init "$@"
elif command -v docker &> /dev/null; then
    echo "Using Docker (ghcr.io/elaraai/e3)..."
    docker run --rm \
        -v "$(pwd):/workspace" \
        -v "${HOME}/.e3:/root/.e3" \
        -w /workspace \
        ghcr.io/elaraai/e3 \
        e3 init "$@"
else
    echo "Error: Neither e3-cli nor Docker is installed."
    echo ""
    echo "Install one of:"
    echo "  - e3-cli: npm install -g @elaraai/e3-cli@beta"
    echo "  - Docker: https://docs.docker.com/get-docker/"
    exit 1
fi
