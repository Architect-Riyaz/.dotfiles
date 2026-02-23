#!/usr/bin/env bash

set -e

DOTFILES_DIR="$HOME/.dotfiles"
USER_FILE="$DOTFILES_DIR/home/user.nix"

USERNAME="$(whoami)"
HOME_DIR="$HOME"

echo "Generating user.nix for user: $USERNAME"
echo "Home directory: $HOME_DIR"

mkdir -p "$DOTFILES_DIR/home"

cat > "$USER_FILE" <<EOF
{ ... }:

{
  home.username = "$USERNAME";
  home.homeDirectory = "$HOME_DIR";
}
EOF

echo "user.nix created at:"
echo "$USER_FILE"
