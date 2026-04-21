# ステップ 4 — git を Home Manager に移して brew uninstall git

## 前提

- ステップ 3 が完了している
- 書籍 Part 2 Ch.11–13 を参照

## 手順

### zsh / bash

```bash
sudo cp step/4/home.nix /Users/nix-demo/.config/home-manager/home.nix
sudo chown nix-demo:staff /Users/nix-demo/.config/home-manager/home.nix
sudo -i -u nix-demo zsh -c 'nix run home-manager/master -- switch --flake /Users/nix-demo/.config/home-manager'
sudo -i -u nix-demo zsh -c 'brew uninstall git'
```

### nushell

```nushell
sudo cp step/4/home.nix /Users/nix-demo/.config/home-manager/home.nix
sudo chown nix-demo:staff /Users/nix-demo/.config/home-manager/home.nix
sudo -i -u nix-demo zsh -c 'nix run home-manager/master -- switch --flake /Users/nix-demo/.config/home-manager'
sudo -i -u nix-demo zsh -c 'brew uninstall git'
```

## 動作確認

### zsh / bash

```bash
sudo -i -u nix-demo zsh -c 'which git && git --version'
```

### nushell

```nushell
sudo -i -u nix-demo zsh -c 'which git && git --version'
```

## 次

ステップ 5 へ進む
