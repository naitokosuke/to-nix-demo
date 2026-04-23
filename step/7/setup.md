# ステップ 7 — nix-darwin で Homebrew Cask を宣言的に管理する

## 前提

- ステップ 6 が完了している
- nix-demo ユーザーで macOS にログイン済み
- sudo パスワード（nix-darwin のシステム反映に必要）
- 書籍 Part 3 Ch.16–21 を参照

## 手順

### zsh / bash

```bash
mkdir -p ~/.config/nix-darwin
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/7/flake.nix ~/.config/nix-darwin/flake.nix
cd ~/.config/nix-darwin && git init && git add flake.nix
nix run nix-darwin/master#darwin-rebuild -- switch --flake . |& nom
```

### nushell

```nushell
mkdir -p ~/.config/nix-darwin
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/7/flake.nix ~/.config/nix-darwin/flake.nix
cd ~/.config/nix-darwin; git init; git add flake.nix
nix run nix-darwin/master#darwin-rebuild -- switch --flake . |& nom
```

## 動作確認

### zsh / bash

```bash
darwin-rebuild --list-generations
brew list --cask
ls ~/Applications/ | rg Ghostty
```

### nushell

```nushell
darwin-rebuild --list-generations
brew list --cask
ls ~/Applications/ | rg Ghostty
```

## メモ

### nix-darwin の `homebrew` モジュールが何をするか

`flake.nix` の該当ブロック:

```nix
homebrew = {
  enable = true;
  onActivation.cleanup = "uninstall";
  casks = [ "ghostty" ];
};
```

- `enable = true` — nix-darwin がこの宣言を `brew bundle` に変換して毎回の switch で反映させる
- `casks = [ "ghostty" ]` — 宣言的に入れておきたい cask のリスト
- `onActivation.cleanup = "uninstall"` — **宣言リストに無い cask / formula は自動で uninstall される**。手動で `brew install something` しても次の switch で消える

これで「ghostty はあくまで Homebrew 経由」「だけど何を入れるかは Nix 側のコードで管理」という状態になる。GUI アプリは Nixpkgs に無いものが多いので、この方式が現実的な落とし所。

### 追加・削除の流れ

1. `~/.config/nix-darwin/flake.nix` の `casks` を編集
2. `cd ~/.config/nix-darwin && darwin-rebuild switch --flake .`
3. 追加したものは brew 経由で install、削除したものは uninstall される

### `brew install --cask` を直接叩いた場合

cleanup が `uninstall` 設定なので次の switch で消える。「手動で入れた一時的な cask も、Nix 側で宣言しないと揮発する」というのが宣言的管理の挙動。

### `nix run home-manager/master` との違い

- Home Manager: ユーザー単位 (`~/.nix-profile`)。sudo 不要。dotfile / CLI ツール管理が主
- nix-darwin: **システム単位** (`/etc`, `/Library/LaunchDaemons` など)。sudo 必須。macOS システム設定や Homebrew のような system-level の管理が主

## 次

ステップ 8 へ進む
