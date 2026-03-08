{ pkgs, ... }:

{
  programs.zsh.shellAliases = {
    DOCKER_APPS_DATA_PATH = "/mnt/d/apps/docker-apps";
  };

  programs.zsh.initContent = ''
    # Remove Windows paths from WSL
    export PATH=$(echo "$PATH" | tr ':' '\n' | grep -v '/mnt/c' | paste -sd ':' -)
    
    alias paste="powershell.exe -Command \"Get-Clipboard\""
    alias copy="powershell.exe -NoProfile -Command \"[Console]::In.ReadToEnd() | Set-Clipboard\""
  '';
}
