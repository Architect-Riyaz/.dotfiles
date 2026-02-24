# Load nix
source $HOME/.nix-profile/etc/profile.d/nix.sh;
# Ansible aliases
alias ap="ansible-playbook"
alias av="ansible-vault"

# Custom prompt (like your bash)
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '[%b]'

setopt PROMPT_SUBST
PROMPT='%F{green}%n%f (%1~)%F{214}''${vcs_info_msg_0_}%f %F{yellow}%*%f
>'

