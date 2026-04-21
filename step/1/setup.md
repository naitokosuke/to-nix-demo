# ステップ 1 — ASIS 環境を構築する

## 前提

- ステップ 0 が完了している
- Xcode Command Line Tools がインストール済み
- インターネット接続あり

```bash
xcode-select -p
```

未インストールの場合

```bash
xcode-select --install
```

## 手順

パスワードは 2 回聞かれる（外側 sudo で naitokosuke、script 内 `sudo -v` で nix-demo の `demo`）

### zsh / bash

```bash
sudo -u nix-demo -H bash -s < step/1/setup.sh
```

### nushell

`bash` に入ってから zsh / bash 版のコマンドを実行する

## 動作確認

### zsh / bash

```bash
sudo -i -u nix-demo zsh -s < step/1/verify.sh
```

### nushell

`bash` に入ってから zsh / bash 版のコマンドを実行する

期待される状態

- `git`, `starship`, `mise` が `/opt/homebrew/bin/` 以下
- `cargo`, `rustc`, `rg` が `~/.cargo/bin/` 以下
- `mise which node` が `~/.local/share/mise/installs/node/.../bin/node` を返す
- `~/.vite-plus/current/bin/vp` が存在する
- `brew list` に `git`, `starship`, `mise` が含まれる
- `brew list --cask` に `ghostty` が含まれる

## 次

Phase 1 完了
