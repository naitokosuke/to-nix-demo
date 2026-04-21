# ステップ 1 — ASIS 環境を構築する

nix-demo のホームに、CLAUDE.md の "ASIS — Before" テーブルに対応した 7 ツールを 5 種類の方法でインストールする
実際の作業はこのディレクトリの `setup.sh` が行う

## 前提

- ステップ 0 が完了している
- Xcode Command Line Tools がインストール済み
- インターネット接続あり
- このリポジトリが naitokosuke の home にクローン済み

Xcode Command Line Tools の有無はこれで確認できる

```bash
xcode-select -p
```

パスが表示されなければ、先に naitokosuke で以下を実行してインストールする
CLT はシステムワイドなので一度入れれば nix-demo 側でも使える

```bash
xcode-select --install
```

## 手順

naitokosuke のターミナルで、このリポジトリのルートから実行する
`sudo -u nix-demo -H` により nix-demo のユーザー権限と home で走らせる

```bash
sudo -u nix-demo -H bash -s < step/1/setup.sh
```

パスワードは 2 回聞かれる

- 外側の `sudo -u nix-demo -H` で naitokosuke のパスワード（ユーザー切り替えの許可）
- スクリプト冒頭の `sudo -v` で nix-demo のパスワード `demo`（以降の Homebrew インストール用キャッシュ）

以降は sudo のクレデンシャルキャッシュが効いて追加入力なしで進む
ただしキャッシュは 5 分でタイムアウトするので、長時間処理中に期限切れになった場合は都度 `demo` を入れ直す

完了までは 10 〜 30 分程度（ネット帯域とマシンスペック次第）

## 動作確認

naitokosuke のターミナルから nix-demo として確認する
`sudo -i -u nix-demo` は nix-demo のログインシェルで実行し、`.zshenv` と `.zprofile` を source するので brew / rustup 系ツールに PATH が通る

```bash
sudo -i -u nix-demo zsh -c '
  echo "== brew formulae =="
  which git starship mise
  echo
  echo "== rustup / cargo =="
  which cargo rustc rg
  echo
  echo "== mise-managed node =="
  mise which node
  echo
  echo "== vp =="
  ls ~/.vite-plus/current/bin/vp
  echo
  echo "== brew list =="
  brew list
  echo
  echo "== brew list --cask =="
  brew list --cask
'
```

`node` と `vp` の PATH 設定は `~/.zshrc` にあり、非インタラクティブなログインシェルでは source されない
そのため `which node` `which vp` ではなく `mise which node` と vp の絶対パス確認で代替している
実際の PATH 通りは撮影時に GUI ログインした nix-demo の zsh で自動的に効く

期待される状態

- `git`, `starship`, `mise` が `/opt/homebrew/bin/` 以下に見える
- `cargo`, `rustc`, `rg` が `~/.cargo/bin/` 以下に見える
- `mise which node` が `~/.local/share/mise/installs/node/.../bin/node` を返す
- `~/.vite-plus/current/bin/vp` が存在する
- `brew list` に `git`, `starship`, `mise` が含まれる
- `brew list --cask` に `ghostty` が含まれる

## トラブルシュート

### `xcrun: error: invalid active developer path`

Command Line Tools が未インストール
前提セクションの手順で入れ直す

### Homebrew install でパーミッションエラーが出る

nix-demo が admin group に入っていない可能性がある
ステップ 0 末尾の `dseditgroup` コマンドで追加してから再実行する

### 途中で失敗した

ログで原因を確認したうえで、もう一度同じコマンドで再実行する
`setup.sh` の各ステップはおおむね冪等に書いてあるので、途中からやり直せる

### sudo のパスワードを何度も聞かれる

sudo のクレデンシャルキャッシュは 5 分でタイムアウトする
本ステップの処理は 10 〜 30 分かかるので、途中で `demo` の入力を求められることがある
その場合は都度入力する（処理は中断せず続行される）

## 次

Phase 1（撮影前の環境構築）はここで完了
GUI で nix-demo にログインし直し、`CLAUDE.md` の "Demo Storyline" に沿って撮影フェーズに入る
