#!/usr/bin/env bash
#
# step/1/setup.sh
#
# Constructs the ASIS "scattered toolchain" environment for the to-nix-demo
# recording: installs 7 tools via 5 different methods, matching the "Before"
# table in CLAUDE.md.
#
# Run AS: nix-demo (freshly created admin user from step 0)
# Intended invocation (from naitokosuke, at repo root):
#   sudo -u nix-demo -H bash -s < step/1/setup.sh
# See step/1/setup.md for the full procedure.

# Bootstrap: when invoked via `bash -s < file`, stdin is the script file. Any
# subprocess (e.g. a hook spawned by `brew install`) that reads stdin would
# consume the remaining script content. Slurp the rest of stdin and re-exec
# with stdin closed so subprocesses inherit /dev/null.
if [ -z "${_SETUP_CLEAN_STDIN:-}" ] && [ ! -t 0 ]; then
  _SETUP_CLEAN_STDIN=1 exec bash -c "$(cat)" </dev/null
fi

# Isolate nix-demo from the host's Nix environment. This machine has
# nix-darwin installed system-wide (e.g. /run/current-system/sw/bin has
# rustup), but the demo premise is "a user who does not know Nix migrates to
# Nix". Any leak from the host defeats that premise. Reset PATH to macOS
# defaults and drop any NIX_* env vars that sudo may have passed through.
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
for _v in ${!NIX_*}; do unset "$_v"; done
unset _v

set -euo pipefail

# ---------- sanity checks ----------

if [ "$(whoami)" != "nix-demo" ]; then
  echo "ERROR: run this script as user 'nix-demo'. Currently: $(whoami)" >&2
  echo "       From naitokosuke's shell, at repo root:" >&2
  echo "         sudo -u nix-demo -H bash -s < step/1/setup.sh" >&2
  exit 1
fi

if [ "$(uname -m)" != "arm64" ]; then
  echo "ERROR: Apple Silicon required. uname -m: $(uname -m)" >&2
  exit 1
fi

if ! xcode-select -p >/dev/null 2>&1; then
  echo "ERROR: Xcode Command Line Tools missing." >&2
  echo "       Run 'xcode-select --install' first, complete the GUI prompt," >&2
  echo "       then re-run this script." >&2
  exit 1
fi

echo "==> Caching sudo credentials (you will be prompted once)"
sudo -v

# ---------- Homebrew (nix-demo isolated prefix; do not touch host /opt/homebrew) ----------

BREW_PREFIX="$HOME/homebrew"

echo "==> Installing Homebrew at $BREW_PREFIX"
if [ ! -x "$BREW_PREFIX/bin/brew" ]; then
  mkdir -p "$BREW_PREFIX"
  curl -fsSL https://github.com/Homebrew/brew/tarball/master \
    | tar xz --strip 1 -C "$BREW_PREFIX"
fi

BREW_SHELLENV="eval \"\$($BREW_PREFIX/bin/brew shellenv)\""
touch "$HOME/.zprofile"
if ! grep -qF "$BREW_SHELLENV" "$HOME/.zprofile"; then
  echo "$BREW_SHELLENV" >> "$HOME/.zprofile"
fi
eval "$("$BREW_PREFIX"/bin/brew shellenv)"

# ---------- brew formulae (source-built at custom prefix; bottles do not apply) ----------

echo "==> brew install git starship mise"
brew install git starship mise

# ---------- brew cask (install app to nix-demo's ~/Applications, not /Applications) ----------

echo "==> brew install --cask ghostty"
mkdir -p "$HOME/Applications"
brew install --cask ghostty --appdir="$HOME/Applications"

# ---------- rustup ----------

echo "==> Installing rustup via curl (non-interactive)"
if [ ! -x "$HOME/.cargo/bin/rustup" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- -y --default-toolchain stable
fi
# rustup writes PATH setup to ~/.zshenv and ~/.profile; source it for this shell
# shellcheck disable=SC1091
. "$HOME/.cargo/env"

# ---------- cargo-installed tool ----------

echo "==> cargo install ripgrep"
cargo install ripgrep

# ---------- mise-managed Node.js ----------

echo "==> mise: install Node.js (LTS)"
eval "$(mise activate bash)"
mise use --global node@lts

# ---------- vp (Vite Plus) ----------

echo "==> Installing Vite Plus (vp) via curl"
# vp installer writes to ~/.vite-plus/ and appends vp env to ~/.zshrc
curl -fsSL https://vite.plus | bash

# ---------- ~/.zshrc assembly ----------

echo "==> Configuring ~/.zshrc (mise activate + starship init last)"
ZSHRC="$HOME/.zshrc"
touch "$ZSHRC"

if ! grep -qF 'mise activate zsh' "$ZSHRC"; then
  echo 'eval "$(mise activate zsh)"' >> "$ZSHRC"
fi

# starship must be last per CLAUDE.md: strip existing occurrences, then append
if grep -qF 'starship init zsh' "$ZSHRC"; then
  grep -vF 'starship init zsh' "$ZSHRC" > "$ZSHRC.tmp" && mv "$ZSHRC.tmp" "$ZSHRC"
fi
echo 'eval "$(starship init zsh)"' >> "$ZSHRC"

echo
echo "==> Done. Open a new zsh session and verify:"
echo "    which git starship mise cargo rustc rg node vp"
