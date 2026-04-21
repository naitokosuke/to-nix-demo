# ステップ 7 — devShell を flake.nix で定義して nix develop

## 前提

- ステップ 6 が完了している
- 書籍 Part 4 Ch.22–29 を参照

## 手順

### zsh / bash

```bash
sudo mkdir -p /Users/nix-demo/demo-project
sudo cp step/7/flake.nix /Users/nix-demo/demo-project/flake.nix
sudo chown -R nix-demo:staff /Users/nix-demo/demo-project
sudo -i -u nix-demo zsh -c 'cd ~/demo-project && nix develop --command zsh -c "which node pnpm jq"'
```

### nushell

```nushell
sudo mkdir -p /Users/nix-demo/demo-project
sudo cp step/7/flake.nix /Users/nix-demo/demo-project/flake.nix
sudo chown -R nix-demo:staff /Users/nix-demo/demo-project
sudo -i -u nix-demo zsh -c 'cd ~/demo-project && nix develop --command zsh -c "which node pnpm jq"'
```

## 動作確認

### zsh / bash

```bash
sudo -i -u nix-demo zsh -c 'cd ~/demo-project && nix develop --command node --version'
```

### nushell

```nushell
sudo -i -u nix-demo zsh -c 'cd ~/demo-project && nix develop --command node --version'
```

## 次

デモ全工程完了
