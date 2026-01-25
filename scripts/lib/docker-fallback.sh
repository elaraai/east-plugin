#!/usr/bin/env bash
# Docker fallback pattern for CLI commands
# Source this file: source "$(dirname "$0")/../lib/docker-fallback.sh"

run_cli() {
    local cli="$1" image="$2"; shift 2
    if command -v "$cli" &> /dev/null; then
        "$cli" "$@"
    elif command -v docker &> /dev/null; then
        docker run --rm -v "$(pwd):/workspace" -v "${HOME}/.e3:/root/.e3" -w /workspace "$image" "$cli" "$@"
    else
        echo "Error: Neither '$cli' nor Docker installed." >&2; exit 1
    fi
}

run_cli_interactive() {
    local cli="$1" image="$2"; shift 2
    if command -v "$cli" &> /dev/null; then
        "$cli" "$@"
    elif command -v docker &> /dev/null; then
        docker run --rm -it -v "$(pwd):/workspace" -v "${HOME}/.e3:/root/.e3" -w /workspace "$image" "$cli" "$@"
    else
        echo "Error: Neither '$cli' nor Docker installed." >&2; exit 1
    fi
}
