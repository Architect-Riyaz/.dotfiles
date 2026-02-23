{ pkgs, ... }:

{
  programs.zsh.shellAliases = {
    DOCKER_APPS_DATA_PATH = "/mnt/d/apps/docker_apps";
  };

  programs.zsh.initContent = ''
    # Remove Windows paths from WSL
    export PATH=$(echo "$PATH" | tr ':' '\n' | grep -v '/mnt/c' | paste -sd ':' -)
    
    alias pbpaste="powershell.exe -Command \"Get-Clipboard\""
    alias pbcopy="powershell.exe -NoProfile -Command \"[Console]::In.ReadToEnd() | Set-Clipboard\""
  '';
}
