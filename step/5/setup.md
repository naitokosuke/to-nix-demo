# ステップ 5 — starship を programs.starship に移して .zshrc を HM 管理下に

## 前提

- ステップ 4 が完了している
- nix-demo ユーザーで macOS にログイン済み
- 書籍 Part 2 Ch.11 を参照

## 手順

### zsh / bash

```bash
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/5/home.nix ~/.config/home-manager/home.nix
nix run home-manager/master -- switch --flake ~/.config/home-manager -b hm-backup |& nom
brew uninstall starship
```

### nushell

```nushell
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/5/home.nix ~/.config/home-manager/home.nix
nix run home-manager/master -- switch --flake ~/.config/home-manager -b hm-backup |& nom
brew uninstall starship
```

## 動作確認

### zsh / bash

```bash
which starship && starship --version
```

### nushell

```nushell
which starship && starship --version
```

詳しい解説は [notes.md](./notes.md) を参照。

## 次

ステップ 6 へ進む
