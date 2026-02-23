{ config, pkgs, ... }:

{
#  home.username = builtins.getEnv "USER";
#  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "24.05";

  # ---------- Packages ----------
  home.packages = with pkgs; [
    git
    vim
    nodejs_24
    corepack
    pnpm
    ansible
    docker
  ];

  # ---------- Docker Aliases ----------
  home.file.".docker_app_aliases".source =
    ../docker/docker_app_aliases.sh;

  # ---------- ZSH ----------
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
    };

    initExtra = ''
      # Load docker aliases
      source $HOME/.docker_app_aliases

      # Enable corepack
      corepack enable

      # PNPM path
      export PNPM_HOME="$HOME/.local/share/pnpm"
      export PATH="$PNPM_HOME:$PATH"

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
    userName = "Your Name";
    userEmail = "your@email.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  # ---------- Direnv ----------
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
