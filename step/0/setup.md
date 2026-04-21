# ステップ 0 — nix-demo ユーザーを作成する

## 前提

- Apple Silicon 搭載の macOS
- naitokosuke が admin 権限を持つ

## 手順

### zsh / bash

```bash
sudo sysadminctl -addUser nix-demo \
  -fullName "Nix Demo" \
  -password demo \
  -admin
```

### nushell

```nushell
sudo sysadminctl -addUser nix-demo -fullName "Nix Demo" -password demo -admin
```

## 動作確認

### zsh / bash

```bash
id nix-demo
ls /Users/nix-demo
groups nix-demo | tr ' ' '\n' | grep -q admin && echo "admin: OK" || echo "admin: MISSING"
```

### nushell

```nushell
id nix-demo
ls /Users/nix-demo
if (groups nix-demo | str contains "admin") { "admin: OK" } else { "admin: MISSING" }
```

## 次

`step/1/setup.md` へ進む
