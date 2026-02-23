#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
  echo "Usage: ./bootstrap.sh [wsl|debian|mac]"
  exit 1
fi

TARGET=$1

mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

nix run github:nix-community/home-manager -- switch --flake ~/.dotfiles#$TARGET

echo "Done. Restart terminal."
