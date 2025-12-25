#!/usr/bin/env bash
# e3 get script - uses local e3 if available, falls back to Docker
set -e

if command -v e3 &> /dev/null; then
    e3 get "$@"
elif command -v docker &> /dev/null; then
    docker run --rm \
        -v "$(pwd):/workspace" \
        -v "${HOME}/.e3:/root/.e3" \
        -w /workspace \
        ghcr.io/elaraai/e3 \
        e3 get "$@"
else
    echo "Error: Neither e3-cli nor Docker is installed."
    exit 1
fi
