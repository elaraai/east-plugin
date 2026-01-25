#!/usr/bin/env bash
source "$(dirname "$0")/../lib/docker-fallback.sh"
run_cli e3 ghcr.io/elaraai/e3 logs "$@"
