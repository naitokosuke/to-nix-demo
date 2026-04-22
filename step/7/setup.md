# ステップ 7 — devShell を flake.nix で定義して nix develop

## 前提

- ステップ 6 が完了している
- nix-demo ユーザーで macOS にログイン済み
- 書籍 Part 4 Ch.22–29 を参照

## 手順

### zsh / bash

```bash
mkdir -p ~/demo-project
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/7/flake.nix ~/demo-project/flake.nix
cd ~/demo-project && git init && git add flake.nix
nix develop --command zsh -c "which node pnpm jq"
```

### nushell

```nushell
mkdir -p ~/demo-project
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/7/flake.nix ~/demo-project/flake.nix
cd ~/demo-project; git init; git add flake.nix
nix develop --command zsh -c "which node pnpm jq"
```

## 動作確認

### zsh / bash

```bash
cd ~/demo-project && nix develop --command node --version
```

### nushell

```nushell
cd ~/demo-project; nix develop --command node --version
```

## 次

デモ全工程完了
