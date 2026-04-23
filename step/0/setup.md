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

```bash
sudo sysadminctl interactive -secureTokenOn nix-demo -password demo
```

### nushell

```nushell
sudo sysadminctl -addUser nix-demo -fullName "Nix Demo" -password demo -admin
```

```nushell
sudo sysadminctl interactive -secureTokenOn nix-demo -password demo
```

## 動作確認

### zsh / bash

```bash
id nix-demo
```

```bash
ls /Users/nix-demo
```

```bash
groups nix-demo | tr ' ' '\n' | grep -q admin && echo "admin: OK" || echo "admin: MISSING"
```

```bash
sudo sysadminctl -secureTokenStatus nix-demo
```

### nushell

```nushell
id nix-demo
```

```nushell
ls /Users/nix-demo
```

```nushell
if (groups nix-demo | str contains "admin") { "admin: OK" } else { "admin: MISSING" }
```

```nushell
sudo sysadminctl -secureTokenStatus nix-demo
```

## 次

`step/1/setup.md` へ進む
