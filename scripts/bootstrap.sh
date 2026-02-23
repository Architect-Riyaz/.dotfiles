
#!/usr/bin/env bash

usage() {
  cat <<EOF
Usage: $(basename "$0") <wsl|debian|mac>

This script generates home/user.nix for the current user and
applies the Home Manager configuration for the specified system.
EOF
}

if [ "${1:-}" = "" ] || [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  usage
  exit 1
fi

TARGET=$1

DOTFILES_DIR="$HOME/.dotfiles"
USER_FILE="$DOTFILES_DIR/home/user.nix"

USERNAME="$(whoami)"
HOME_DIR="$HOME"

echo "Generating $USER_FILE for user: $USERNAME"
mkdir -p "$DOTFILES_DIR/home"

cat > "$USER_FILE" <<EOF
{ ... }:

{
  home.username = "$USERNAME";
  home.homeDirectory = "$HOME_DIR";
}
EOF

echo "Wrote $USER_FILE"

mkdir -p "$HOME/.config/nix"
echo "experimental-features = nix-command flakes" > "$HOME/.config/nix/nix.conf"

echo "Applying Home Manager configuration for: $TARGET"
nix run github:nix-community/home-manager -- switch --flake "$DOTFILES_DIR#$TARGET" -b backup

echo "Done. Restart terminal."
