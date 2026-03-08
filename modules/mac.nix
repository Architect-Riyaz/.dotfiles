{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  programs.zsh = {
    enable = true;

    initContent = ''
      alias copy="pbcopy"
      alias paste="pbpaste"
    '';
  };
}
