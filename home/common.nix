{ config, pkgs, ... }:

{
#  home.username = builtins.getEnv "USER";
#  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  
  # ---------- Packages ----------
  home.packages = with pkgs; [
    git
    stow
    vim
    nodejs_24
    pnpm
    ansible
    docker
    jq
    yq
    sshpass
    tree
  ];

  # ---------- Docker Aliases ----------
  home.file = {
   ".docker/.apps".source =../files/common/docker/.apps;
   ".gitconfig".source = ../files/common/git/.gitconfig;
  };
  # ---------- ZSH ----------
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
    };
    initContent = ''
      # Load nix
      source $HOME/.nix-profile/etc/profile.d/nix.sh;

      # Load docker aliases
      source $HOME/.docker/.apps

      # Use pnpm provided by Nix (do not override PATH here)

      # Custom prompt (like your bash)
      autoload -Uz vcs_info
      precmd() { vcs_info }
      zstyle ':vcs_info:git:*' formats '[%b]'

      setopt PROMPT_SUBST
       PROMPT='%F{green}%n%f (%1~)%F{214}''${vcs_info_msg_0_}%f %F{yellow}%*%f
> '
    '';
  };
 # ---------- Git ----------
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  # ---------- Direnv ----------
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
