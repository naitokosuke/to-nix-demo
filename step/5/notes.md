# ステップ 5 メモ — switch コマンドの意味

## `-b hm-backup` が必要な理由

Home Manager は `programs.zsh.enable = true` で `~/.zshrc` を宣言的に上書きしようとする。ここまでのデモでは step 1 の Homebrew 導入時に既存の `~/.zshrc` が手で書かれており、そのまま switch すると

```
Existing file '/Users/nix-demo/.zshrc' would be clobbered by backing it up as '...'
```

というエラーで **switch 全体が中断**される（starship パッケージも入らない）。

`-b hm-backup` を付けると HM は衝突する既存ファイルを `.hm-backup` 拡張子でリネーム退避してから書き込みを続行する。つまり

- `~/.zshrc` → `~/.zshrc.hm-backup` として残る
- 新しい HM 管理の `~/.zshrc` が作成される
- switch が最後まで走り、starship も含め全パッケージがインストールされる

### `-b` は初回だけ。以降は付けない

HM は **自分が前回書いたファイル** を記録している。一度 HM 管理になった `~/.zshrc` は、2 回目以降の switch では `-b` 無しでもそのまま上書きできる（差分適用。これが宣言的な挙動）。

| 状況 | HM の挙動 |
|------|----------|
| 自分が前回書いたファイル | 差分で上書き OK |
| 自分が書いていない既存ファイル | clobber 拒否。`-b` で退避許可する必要あり |

運用:

```bash
# 初回のみ（手動で作られた .zshrc などを HM 管理下に取り込むとき）
nix run home-manager/master -- switch --flake ~/.config/home-manager -b hm-backup

# 2 回目以降（home.nix を編集したとき / 通常運用）
nix run home-manager/master -- switch --flake ~/.config/home-manager
```

2 回目以降に `-b hm-backup` を付け続けると、既存の `.hm-backup` とぶつかって逆に詰まる（新しい `.hm-backup` を書こうとするが同名ファイルが既存）。その場合は `-b` を外すか、古い `.hm-backup` を退避してから実行する。
