Tauri launcher build instructions

This folder contains a Tauri scaffold that wraps the static prototype UI (from `/var/www/html/launcher-web`).

What I added
- Minimal `package.json` with Tauri CLI dev/build scripts
- `src/` contains the prototype UI (index.html, styles, app.js) that will be used as the frontend
- `src-tauri/tauri.conf.json` with basic bundle settings
- `scripts/build-windows.sh` : helper script to run `tauri build` (requires dependencies below)

Requirements to build (on a builder machine)
- Node.js >= 16
- Rust toolchain (rustup + stable)
- `cargo` and `cargo install tauri-cli` (or use `npx @tauri-apps/cli`)
- For cross-compiling to Windows on Linux: mingw-w64 and proper Rust target (e.g., x86_64-pc-windows-gnu)

Quick build (recommended on target OS):

# Install dependencies
npm install

# Build and bundle (on the OS you target)
npx tauri build

After successful build the installers/bundles will be in `src-tauri/target/release/bundle`.

Notes
- I could not produce a signed Windows executable from this Ubuntu host automatically. You should run the build on a Windows builder or configure cross-compilation with mingw and the correct Rust targets.
- If you want, I can prepare a GitHub Actions workflow to build Windows artifacts automatically in CI and deliver the .exe/.msi for you to download.
 
CI Workflow
----------
I added a GitHub Actions workflow `.github/workflows/build-windows.yml` that runs on `windows-latest` and builds the Tauri Windows bundles. To use it:

1. Push this repository branch to GitHub (to `main` or open a PR).
2. Go to the Actions tab and run `Build Tauri Windows` or wait for a push to `main`.
3. After the job completes, artifacts will be available under the workflow run named `tauri-windows-bundles` (look inside `src-tauri/target/release/bundle`).

Notes on Signatures
-------------------
If you need signed installers/executables, configure code signing in the workflow using a secure secrets store (e.g., signtool on Windows with a PFX file via Actions Secrets). I can prepare an example step if you want.
