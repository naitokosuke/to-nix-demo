# ステップ 4 — git を Home Manager に移して brew uninstall git

## 前提

- ステップ 3 が完了している
- nix-demo ユーザーで macOS にログイン済み
- 書籍 Part 2 Ch.11–13 を参照

## 手順

### zsh / bash

```bash
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/4/home.nix ~/.config/home-manager/home.nix
nix run home-manager/master -- switch --flake ~/.config/home-manager |& nom
brew uninstall git
```

### nushell

```nushell
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/4/home.nix ~/.config/home-manager/home.nix
nix run home-manager/master -- switch --flake ~/.config/home-manager |& nom
brew uninstall git
```

## 動作確認

### zsh / bash

```bash
which git && git --version
```

### nushell

```nushell
which git && git --version
```

## 次

ステップ 5 へ進む
