{ pkgs, ... }:

{
  programs.zsh.shellAliases = {
    DOCKER_APPS_DATA_PATH = "/mnt/d/apps/docker_apps";
  };

  programs.zsh.initExtra = ''
    alias pbpaste="powershell.exe -Command \"Get-Clipboard\""
    alias pbcopy="powershell.exe -NoProfile -Command \"[Console]::In.ReadToEnd() | Set-Clipboard\""
  '';
}
