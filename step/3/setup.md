# ステップ 3 — Home Manager で ripgrep / mise / rustup / nom を Nix-store 化

## 前提

- ステップ 2 が完了している
- nix-demo ユーザーで macOS にログイン済み
- 書籍 Part 2 Ch.9–10 / Part 5 Ch.30 付近を参照

## 手順

### zsh / bash

```bash
nix run home-manager/master -- init --switch
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/3/home.nix ~/.config/home-manager/home.nix
nix run home-manager/master -- switch --flake ~/.config/home-manager |& nix run nixpkgs#nix-output-monitor
```

### nushell

```nushell
nix run home-manager/master -- init --switch
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/3/home.nix ~/.config/home-manager/home.nix
nix run home-manager/master -- switch --flake ~/.config/home-manager |& nix run nixpkgs#nix-output-monitor
```

次回以降の switch は `|& nom` で OK。

## 動作確認

### zsh / bash

```bash
which rg mise rustup nom
```

### nushell

```nushell
which rg mise rustup nom
```

## 次

ステップ 4 へ進む
