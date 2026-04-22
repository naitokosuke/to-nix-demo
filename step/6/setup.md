# ステップ 6 — Homebrew を cask のみに絞る

## 前提

- ステップ 5 が完了している
- nix-demo ユーザーで macOS にログイン済み
- 書籍 Part 2 Ch.13 を参照

## 手順

### zsh / bash

```bash
brew uninstall mise
```

### nushell

```nushell
brew uninstall mise
```

## 動作確認

### zsh / bash

```bash
brew list
brew list --cask
which git starship mise rg rustup node vp
```

### nushell

```nushell
brew list
brew list --cask
which git starship mise rg rustup node vp
```

## 次

ステップ 7 へ進む
