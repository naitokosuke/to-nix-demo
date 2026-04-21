# ステップ 3 — Home Manager で ripgrep / mise / rustup を Nix-store 化

## 前提

- ステップ 2 が完了している
- 書籍 Part 2 Ch.9–10 を参照

## 手順

### zsh / bash

```bash
sudo -i -u nix-demo zsh -c 'nix run home-manager/master -- init --switch'
sudo cp step/3/home.nix /Users/nix-demo/.config/home-manager/home.nix
sudo chown nix-demo:staff /Users/nix-demo/.config/home-manager/home.nix
sudo -i -u nix-demo zsh -c 'nix run home-manager/master -- switch --flake /Users/nix-demo/.config/home-manager'
```

### nushell

```nushell
sudo -i -u nix-demo zsh -c 'nix run home-manager/master -- init --switch'
sudo cp step/3/home.nix /Users/nix-demo/.config/home-manager/home.nix
sudo chown nix-demo:staff /Users/nix-demo/.config/home-manager/home.nix
sudo -i -u nix-demo zsh -c 'nix run home-manager/master -- switch --flake /Users/nix-demo/.config/home-manager'
```

## 動作確認

### zsh / bash

```bash
sudo -i -u nix-demo zsh -c 'which rg mise rustup'
```

### nushell

```nushell
sudo -i -u nix-demo zsh -c 'which rg mise rustup'
```

## 次

ステップ 4 へ進む
