# ステップ 2 — Nix をインストールする

## 前提

- ステップ 1 が完了している

## 手順

nix-demo で Nix をインストール

- Lix installer
  - https://lix.systems/install/
- NixOS コミュニティ公式 installer
  - https://github.com/NixOS/nix-installer

## 動作確認

### zsh / bash

```bash
sudo -i -u nix-demo zsh -c 'which nix && nix --version'
```

### nushell

```nushell
sudo -i -u nix-demo zsh -c 'which nix && nix --version'
```

## 次

Phase 2 完了
