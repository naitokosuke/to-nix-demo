# ステップ 9 — Go の devShell を flake.nix で定義して nix develop

## 前提

- ステップ 8 が完了している
- nix-demo ユーザーで macOS にログイン済み
- 書籍 Part 4 Ch.22–29 を参照

## 手順

### zsh / bash

```bash
mkdir -p ~/demo-go
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/9/flake.nix ~/demo-go/flake.nix
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/9/main.go ~/demo-go/main.go
cd ~/demo-go && git init && git add flake.nix main.go
```

### nushell

```nushell
mkdir -p ~/demo-go
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/9/flake.nix ~/demo-go/flake.nix
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/9/main.go ~/demo-go/main.go
cd ~/demo-go; git init; git add flake.nix main.go
```

## devShell に入る

```bash
cd ~/demo-go
nix develop
```

`nix develop` でサブシェル (bash) が開き、`flake.nix` の `packages` に書いたものだけが PATH に入った状態になる。プロンプトが変わり、ホスト側には存在しないはずの `go` / `gopls` / `dlv` / `golangci-lint` が使えるようになる。

## 動作確認 (devShell 内で実行)

```bash
which go gopls dlv golangci-lint
```

```bash
go version
```

```bash
go run main.go
```

```bash
go build -o hello main.go && ./hello
```

```bash
file hello
```

Nix 管理の Go でビルドしたバイナリがそのまま動く。`file hello` で Mach-O の arm64 バイナリが出てくるので、「Nix 経由で入れた Go でも普通に macOS ネイティブのものが吐ける」ことが確認できる。

## devShell から抜ける

```bash
exit
```

抜けると `which go` が空になり、ホスト側に Go が入っていないことが確認できる。**プロジェクトディレクトリに `cd` して `nix develop` したときだけ Go が生える**、という devShell の価値が分かる。

## メモ

### devShell に入れているもの

- `go` — Go コンパイラと標準ツールチェイン (`go`, `gofmt` など)
- `gopls` — 公式 Language Server。LSP 対応エディタから補完 / 定義ジャンプが使える
- `delve` (`dlv`) — デバッガ
- `golangci-lint` — メタリンター

いずれも Nixpkgs の `go` と整合するバージョンが降ってくるので、「go のバージョンと gopls のバージョンが合わなくて壊れる」系の事故が起きにくい。

### プロジェクトごとに Go バージョンを切り替える

`flake.nix` の `packages` を `go_1_22` / `go_1_23` のように明示すれば、プロジェクト単位で Go のバージョンを固定できる。`mise` や `asdf` を使わずに、`flake.nix` を `git` に入れておくだけでチーム全員の Go バージョンが揃う。

### direnv との組み合わせ

`~/demo-go/.envrc` に `use flake` と書いて `direnv allow` すれば、`cd ~/demo-go` しただけで自動的に devShell に入る。ステップ 8 と同じ考え方で、言語が変わっても使い勝手は同じ。

## 次

ステップ 10 へ進む
