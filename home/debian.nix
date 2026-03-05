{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    xclip
    wl-clipboard
  ];
 home.sessionVariables = {
    DOCKER_APPS_DATA_PATH =
      "${config.home.homeDirectory}/apps/docker-apps";
  };
  programs.zsh = {
    enable = true;

    initContent = ''
      copy() {
        if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
          wl-copy
        else
          xclip -selection clipboard
        fi
      }

      paste() {
        if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
          wl-paste
        else
          xclip -selection clipboard -o
        fi
      }
    '';
  };
}
