#!/usr/bin/env bash
set -euo pipefail
# Convenience script to build locally (on the same OS)
if ! command -v npm >/dev/null; then echo "npm missing"; exit 1; fi
npm install
npx tauri build
