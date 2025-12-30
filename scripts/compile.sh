#!/usr/bin/env bash
# East compile script - uses Docker if available, falls back to local
set -e

FILE="${1:-}"

if command -v docker &> /dev/null; then
    echo "Using Docker (ghcr.io/elaraai/east-node)..."

    if [ -f "tsconfig.json" ] && [ -f "package.json" ]; then
        # User has their own project - use it
        docker run --rm -v "$(pwd):/workspace" -w /workspace \
            ghcr.io/elaraai/east-node \
            bash -c "npm install --silent && npx tsc -p tsconfig.json --noEmit"
    elif [ -n "$FILE" ] && [ -f "$FILE" ]; then
        # User specified a file - mount and compile
        docker run --rm -v "$(pwd)/$FILE:/compile/input.ts:ro" \
            -w /compile \
            ghcr.io/elaraai/east-node \
            npx tsc
    else
        echo "Usage: east-compile.sh <file.ts>"
        echo "   or: run from a directory with package.json + tsconfig.json"
        exit 1
    fi
elif command -v npx &> /dev/null; then
    echo "Using local npx..."
    if [ -f "tsconfig.json" ]; then
        [ -d "node_modules" ] || npm install --silent
        npx tsc -p tsconfig.json --noEmit
    elif [ -n "$FILE" ]; then
        npx tsc --noEmit --target ES2022 --lib ES2022 --moduleResolution node --esModuleInterop "$FILE"
    else
        echo "Usage: east-compile.sh <file.ts>"
        exit 1
    fi
else
    echo "Error: Neither Docker nor Node.js/npx is installed."
    echo ""
    echo "Install one of:"
    echo "  - Docker: https://docs.docker.com/get-docker/"
    echo "  - Node.js: https://nodejs.org/ or use nvm"
    exit 1
fi
