# ステップ 3.5 — nix-output-monitor (nom) でビルドを可視化

## 前提

- ステップ 3 が完了している
- 書籍 Part 5 Ch.30 付近を参照

## 手順

### zsh / bash

```bash
sudo cp step/3-5/home.nix /Users/nix-demo/.config/home-manager/home.nix
sudo chown nix-demo:staff /Users/nix-demo/.config/home-manager/home.nix
sudo -i -u nix-demo zsh -c 'nix run home-manager/master -- switch --flake /Users/nix-demo/.config/home-manager |& nix run nixpkgs#nix-output-monitor'
```

### nushell

```nushell
sudo cp step/3-5/home.nix /Users/nix-demo/.config/home-manager/home.nix
sudo chown nix-demo:staff /Users/nix-demo/.config/home-manager/home.nix
sudo -i -u nix-demo zsh -c 'nix run home-manager/master -- switch --flake /Users/nix-demo/.config/home-manager |& nix run nixpkgs#nix-output-monitor'
```

## 動作確認

### zsh / bash

```bash
sudo -i -u nix-demo zsh -c 'which nom && nom --version'
```

### nushell

```nushell
sudo -i -u nix-demo zsh -c 'which nom && nom --version'
```

次回以降の switch は `nom` にパイプすれば進捗がビジュアルに表示される。

```bash
sudo -i -u nix-demo zsh -c 'nix run home-manager/master -- switch --flake /Users/nix-demo/.config/home-manager |& nom'
```

## 次

ステップ 4 へ進む
