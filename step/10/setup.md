# ステップ 10 — devenv で同じ Go 環境を作る

## 前提

- ステップ 9 が完了している
- nix-demo ユーザーで macOS にログイン済み
- 書籍本編では未登場の発展トピック (devenv.sh)

## devenv のインストール

### zsh / bash

```bash
nix profile install nixpkgs#devenv
```

```bash
which devenv
```

### nushell

```nushell
nix profile install nixpkgs#devenv
```

```nushell
which devenv
```

## 手順

### zsh / bash

```bash
mkdir -p ~/demo-go-devenv
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/10/devenv.yaml ~/demo-go-devenv/devenv.yaml
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/10/devenv.nix  ~/demo-go-devenv/devenv.nix
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/10/main.go     ~/demo-go-devenv/main.go
cd ~/demo-go-devenv && git init && git add devenv.yaml devenv.nix main.go
```

### nushell

```nushell
mkdir -p ~/demo-go-devenv
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/10/devenv.yaml ~/demo-go-devenv/devenv.yaml
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/10/devenv.nix  ~/demo-go-devenv/devenv.nix
cp /Users/naitokosuke/src/github.com/naitokosuke/to-nix-demo/step/10/main.go     ~/demo-go-devenv/main.go
cd ~/demo-go-devenv; git init; git add devenv.yaml devenv.nix main.go
```

## devenv に入る

```bash
cd ~/demo-go-devenv
devenv shell
```

`devenv shell` で `devenv.nix` の内容に対応するサブシェル (bash) が開く。初回は依存を取ってくるのに少し時間がかかるが、2 回目以降はキャッシュが効いて一瞬で入れる。

## 動作確認 (devenv 内で実行)

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

step 9 の devShell と**まったく同じ結果**が得られる。ホスト側に Go は入っていないのに、`devenv shell` の中だけで Go が生えていて、吐いたバイナリはシェルを抜けた後も普通に動く。

## devenv から抜ける

```bash
exit
```

抜けると `which go` は空。devShell と同じく、プロジェクトディレクトリ配下でだけ環境が生きる。

## メモ

### devShell (step 9) との書き味の差

step 9 の `flake.nix`:

```nix
devShells.${system}.default = pkgs.mkShell {
  packages = with pkgs; [ go gopls delve golangci-lint ];
};
```

step 10 の `devenv.nix`:

```nix
languages.go.enable = true;

packages = with pkgs; [ gopls delve golangci-lint ];
```

- **devShell**: Nixpkgs のパッケージ名を直接指定する素の Nix。自由度は最大だが、`go` を入れるのに `go` という attribute を知っている必要がある
- **devenv**: `languages.<lang>.enable` という高レベル module がある。言語ごとのベストプラクティス (Go なら `GOPATH` / `GOBIN` / `go env` の設定など) が込みで効く

### devenv が devShell より一歩便利なところ

- `languages.go.package = pkgs.go_1_22;` のようにバージョン指定が直感的
- `services.postgres.enable = true;` などで Postgres / Redis などを宣言的に同梱できる
- `processes.web.exec = "go run main.go";` で `devenv up` すると long-running なプロセスをまとめて起動できる
- `pre-commit.hooks.gofmt.enable = true;` で pre-commit hook も宣言的に管理
- Cachix 連携がデフォルトで入っているので、依存のビルド済みバイナリが降ってきやすい

「flake の devShell に後付けで process-compose / pre-commit / services を足していくと最終的に devenv になる」くらいの関係性。

### 裏側

`devenv.yaml` は flake の `inputs` 相当、`devenv.nix` は `mkShell` 相当のラッパー。`devenv shell` は内部的に `nix develop` を呼ぶ。so `.devenv/` 配下にキャッシュや lock が生える (`devenv.lock`)。

### direnv との組み合わせ

`.envrc` に

```bash
use devenv
```

と書いて `direnv allow` しておけば、`cd ~/demo-go-devenv` しただけで自動で環境に入る。step 9 の `use flake` と揃う体験。

## 次

デモ全工程完了
