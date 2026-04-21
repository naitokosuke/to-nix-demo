# CLAUDE.md

## Project

Demo video for "[ちいさくはじめる Nix](https://zenn.dev/trifolium/books/1c0373f3570334)" (by ryu_trifolium). Create a fresh macOS user with a typical scattered toolchain, then migrate to Nix/Home Manager on camera.

## Book Coverage

| Part | Topic | In Demo |
|------|-------|---------|
| Part 1 (Ch.3-7) | Nix basics (run/shell/search/profile) | ✅ |
| Part 2 (Ch.8-15) | Home Manager, Homebrew migration & coexistence | ✅ Main |
| Part 3 (Ch.16-21) | nix-darwin system management | ✅ |
| Part 4 (Ch.22-29) | Flakes devShell | ✅ |
| Part 5 (Ch.30-34) | Tips (unfree, pinning, override, registry) | Partial |

## ASIS — Before (demo starting state)

A fresh macOS user `nix-demo` is created via `sysadminctl`, then the tools below are installed to simulate a typical developer environment. Full step-by-step procedure is in `docs/setup.md` (user creation → tool installs → verification → post-recording cleanup).

7 tools, 5 different install methods. "Where did I install this from?" chaos.

| Tool | Installed via | Path |
|------|--------------|------|
| git | `brew install` | `/opt/homebrew/bin/git` |
| starship | `brew install` | `/opt/homebrew/bin/starship` |
| mise | `brew install` | `/opt/homebrew/bin/mise` |
| Ghostty | `brew install --cask` | `/Applications/Ghostty.app` |
| rustup → cargo, rustc | curl installer | `~/.cargo/bin/` |
| ripgrep | `cargo install` | `~/.cargo/bin/rg` |
| Node.js | mise | `~/.local/share/mise/installs/node/...` |
| vp (Vite Plus) | curl installer | `~/.vite-plus/current/bin/vp` |

Shell config: `~/.zprofile` (Homebrew), `~/.zshenv` (cargo env), `~/.zshrc` (vp env + mise activate + starship init).

## TOBE — After

| Tool | Managed by | Notes |
|------|-----------|-------|
| git | **Home Manager** `programs.git` | Config declarative |
| starship | **Home Manager** `programs.starship` | TOML in home.nix |
| ripgrep | **Home Manager** `home.packages` | Replaces cargo install |
| mise | **Home Manager** `home.packages` | In Nixpkgs |
| rustup | **Home Manager** `home.packages` | In Nixpkgs; toolchains still via rustup |
| Node.js | **mise** (unchanged) | mise itself is Nix-managed |
| Ghostty | **Homebrew Cask** (stays) | GUI apps stay in brew |
| vp | **Unchanged** | Not in Nixpkgs. Reality: some things remain outside |

## Demo Storyline

1. **Show the mess** — `brew list`, `which` spam, `ls ~/.cargo/bin/` → paths everywhere
2. **Install Nix** — Flakes enabled → `nix run nixpkgs#cowsay` instant payoff
3. **Home Manager migration** (hero moment) — Write `home.nix` → `home-manager switch` → `which` spam again, all paths now `/nix/store/...`
4. **Clean up Homebrew** — `brew uninstall git starship` → everything still works. Ghostty stays in cask.
5. **Realistic coexistence** — mise manages Node.js (mise itself Nix-managed), rustup manages toolchains (rustup itself Nix-managed), vp stays as-is. "You don't have to Nix everything."
6. **devShell** — `flake.nix` in a project → `nix develop` → direnv auto-activation on `cd`

## Key Design Decision: git Migration

Nix Flakes calls git internally, so git must exist before Nix is usable. Flow:

1. Homebrew git is present at start
2. Install Nix (depends on brew git)
3. `programs.git.enable = true` in Home Manager → Nix git takes PATH priority
4. `brew uninstall git` → still works via Nix

## Repo Structure

```
to-nix-demo/
├── CLAUDE.md
├── docs/
│   └── setup.md           # ASIS environment setup procedure
├── demo/
│   ├── home.nix           # TOBE Home Manager config
│   └── flake.nix          # Act 6 devShell example
└── scripts/
```

## Tech Notes

- Apple Silicon assumed (`/opt/homebrew`).
- Vite Plus installer is unstable (early-stage project); writes to `~/.vite-plus/`, appends to `~/.zshrc`.
- rustup installer modifies `~/.zshenv` and `~/.profile`. Use `-y` for non-interactive.
- starship init must be last in `.zshrc` (official recommendation).