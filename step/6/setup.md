# ステップ 6 — Homebrew を cask のみに絞る

## 前提

- ステップ 5 が完了している
- nix-demo ユーザーで macOS にログイン済み
- 書籍 Part 2 Ch.13 を参照

## 手順

### zsh / bash

```bash
brew uninstall mise
brew autoremove
brew uninstall gettext libunistring pkgconf
```

### nushell

```nushell
brew uninstall mise
brew autoremove
brew uninstall gettext libunistring pkgconf
```

`brew autoremove` は依存として引きずられた孤児 formula を掃除する。ただし `gettext` / `libunistring` / `pkgconf` は過去に何らかのタイミングで `on_request`（ユーザーが明示的に入れた扱い）としてマークされているため autoremove の対象外になる。`brew uses --installed` でこれらを使っている formula が無いことを確認した上で、明示的に uninstall してデモの最終状態を「cask だけ」に揃える。

## 動作確認

### zsh / bash

```bash
brew list
```

```bash
brew list --cask
```

```bash
which git starship mise rg rustup node vp
```

### nushell

```nushell
brew list
```

```nushell
brew list --cask
```

```nushell
which git starship mise rg rustup node vp
```

## 次

ステップ 7 へ進む
