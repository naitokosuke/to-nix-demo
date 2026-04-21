#!/usr/bin/env zsh

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
