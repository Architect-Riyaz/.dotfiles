{ pkgs, ... }:

{
  programs.zsh.shellAliases = {
    DOCKER_APPS_PATH = "$HOME/.docker/apps";
    DOCKER_APPS_DATA_PATH = "/mnt/d/apps/docker-apps";
  };

  programs.zsh.initContent = ''
    # Load nix
    source $HOME/.nix-profile/etc/profile.d/nix.sh;

    # WSL Windows path
    if [[ -d /mnt/c ]]; then
      export PATH="$PATH:/mnt/c/Windows/System32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem"
    fi


    # Fix compinit path for WSL
    autoload -Uz compinit
    if [[ -d /usr/share/zsh/site-functions ]]; then
      fpath=(/usr/share/zsh/site-functions $fpath)
    fi
    if [[ -d /usr/local/share/zsh/site-functions ]]; then
      fpath=(/usr/local/share/zsh/site-functions $fpath)
    fi
    compinit

    alias paste="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoProfile -Command Get-Clipboard"
    alias copy="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoProfile -Command \"[Console]::In.ReadToEnd() | Set-Clipboard\""
  '';
}
