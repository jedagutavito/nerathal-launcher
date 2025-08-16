#!/usr/bin/env bash
set -euo pipefail
# Build script for Windows using cross compilation (to be run on a machine with Rust toolchain and mingw installed)
# This script assumes you have installed:
#  - rustup + stable toolchain
#  - cargo install tauri-cli
#  - mingw-w64 for cross compilation (x86_64-pc-windows-gnu) OR build on Windows directly
#  - Node.js and npm

echo "Starting Windows build (cross/host dependent)..."
if ! command -v cargo >/dev/null; then echo "cargo not found. Install Rust toolchain first."; exit 1; fi
if ! command -v npm >/dev/null; then echo "npm not found. Install Node.js first."; exit 1; fi

# Install frontend deps
npm install

# Build and then use tauri to bundle
npm run build || true
# Use tauri CLI to build (this will produce bundles in src-tauri/target/release/bundle)
npx tauri build

echo "Build finished. Check src-tauri/target/release/bundle for installers (.msi, .msi etc.)"
