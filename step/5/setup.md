# ステップ 5 — starship を programs.starship に移して .zshrc を HM 管理下に

## 前提

- ステップ 4 が完了している
- 書籍 Part 2 Ch.11 を参照

## 手順

### zsh / bash

```bash
sudo cp step/5/home.nix /Users/nix-demo/.config/home-manager/home.nix
sudo chown nix-demo:staff /Users/nix-demo/.config/home-manager/home.nix
sudo -i -u nix-demo zsh -c 'nix run home-manager/master -- switch --flake /Users/nix-demo/.config/home-manager -b hm-backup'
sudo -i -u nix-demo zsh -c 'brew uninstall starship'
```

### nushell

```nushell
sudo cp step/5/home.nix /Users/nix-demo/.config/home-manager/home.nix
sudo chown nix-demo:staff /Users/nix-demo/.config/home-manager/home.nix
sudo -i -u nix-demo zsh -c 'nix run home-manager/master -- switch --flake /Users/nix-demo/.config/home-manager -b hm-backup'
sudo -i -u nix-demo zsh -c 'brew uninstall starship'
```

## 動作確認

### zsh / bash

```bash
sudo -i -u nix-demo zsh -c 'which starship && starship --version'
```

### nushell

```nushell
sudo -i -u nix-demo zsh -c 'which starship && starship --version'
```

## 次

ステップ 6 へ進む
