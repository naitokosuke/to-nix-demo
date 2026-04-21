# ステップ 0 — nix-demo ユーザーを作成する

naitokosuke のターミナルで sysadminctl を sudo 実行し、demo 対象の新規ユーザー nix-demo を作成する
後続の step 1 はこのユーザーの権限で動く

## 前提

- Apple Silicon 搭載の macOS
- naitokosuke が admin 権限を持つ

## 手順

`-admin` を付けて admin group に入れることで、step 1 で nix-demo 自身が sudo を使える

```bash
sudo sysadminctl -addUser nix-demo \
  -fullName "Nix Demo" \
  -password demo \
  -admin
```

## 動作確認

作成できたことと admin group に入っていることを確認する

```bash
id nix-demo
ls /Users/nix-demo
groups nix-demo | tr ' ' '\n' | grep -q admin && echo "admin: OK" || echo "admin: MISSING"
```

`admin: MISSING` が出た場合は以下で追加する

```bash
sudo dseditgroup -o edit -a nix-demo -t user admin
```

## トラブルシュート

### `/Users/nix-demo` が存在しない

macOS のバージョンによっては sysadminctl でユーザー作成しても home ディレクトリが自動生成されない
その場合は以下で作成する

```bash
sudo createhomedir -c -u nix-demo
```

## 次

`step/1/setup.md` へ進む
