# ステップ 6 — Homebrew を cask のみに絞る

## 前提

- ステップ 5 が完了している
- 書籍 Part 2 Ch.13 を参照

## 手順

### zsh / bash

```bash
sudo -i -u nix-demo zsh -c 'brew uninstall mise'
```

### nushell

```nushell
sudo -i -u nix-demo zsh -c 'brew uninstall mise'
```

## 動作確認

### zsh / bash

```bash
sudo -i -u nix-demo zsh -c 'brew list'
sudo -i -u nix-demo zsh -c 'brew list --cask'
sudo -i -u nix-demo zsh -c 'which git starship mise rg rustup node vp'
```

### nushell

```nushell
sudo -i -u nix-demo zsh -c 'brew list'
sudo -i -u nix-demo zsh -c 'brew list --cask'
sudo -i -u nix-demo zsh -c 'which git starship mise rg rustup node vp'
```

## 次

ステップ 7 へ進む
