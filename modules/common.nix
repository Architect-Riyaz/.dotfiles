{ config, pkgs, lib, ... }:

{
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  # ---------- Nixpkgs ----------
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [ "vscode" ];
  };

  # ---------- Overlays ----------
  nixpkgs.overlays = [
    (final: prev: {
      # example custom package override
      mytool = prev.somePackage;
    })
  ];

  # ---------- Packages ----------
  home.packages = with pkgs; [

    # System / Monitoring
    btop
    tree
    ncdu
    chafa

    # CLI Utilities
    eza
    fzf
    jq
    yq-go
    sshpass

    # Editors / Terminal
    vim
    tmux

    # JavaScript
    nodejs_24
    pnpm

    # DevOps
    ansible

    # Git / Docker
    lazygit
    lazydocker

    # AI
    llmfit

    # Misc
    opencode
  ];

  # ---------- Files ----------
  home.file = {
    ".docker/.apps".source = ../files/common/docker/.apps;
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
      lg = "lazygit";
      ld = "lazydocker";
      img = "chafa";
    };

    initContent = ''
      # Load nix profile
      if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        source "$HOME/.nix-profile/etc/profile.d/nix.sh"
      elif [ -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
        source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
      fi

      # Load docker aliases
      source "$HOME/.docker/.apps"

      # -------- Completion tuning --------
      # Case insensitive completion
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

      # Better completion behavior
      zstyle ':completion:*' menu select

      # -------- Prompt --------
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
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

}
