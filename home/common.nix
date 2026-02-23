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

    initContent = ''
      # Load docker aliases
      source $HOME/.docker_app_aliases

      # Enable corepack if available (avoid "command not found" errors)
      if command -v corepack >/dev/null 2>&1; then
        corepack enable
      fi

      # Use pnpm provided by Nix (do not override PATH here)

      # Custom prompt (like your bash)
      autoload -Uz vcs_info
      precmd() { vcs_info }
      zstyle ':vcs_info:git:*' formats '[%b]'

      setopt PROMPT_SUBST
      PROMPT="%F{green}%n%f (%1~)%F{214}${vcs_info_msg_0_}%f %F{yellow}%*%f
    > "
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
