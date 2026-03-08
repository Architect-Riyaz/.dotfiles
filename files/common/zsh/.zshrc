# WSL Windows path
if [[ -d /mnt/c ]]; then
  export PATH="$PATH:/mnt/c/Windows/System32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem"
fi

# Load nix
source $HOME/.nix-profile/etc/profile.d/nix.sh;

# Fix compinit path for WSL
autoload -Uz compinit
if [[ -d /usr/share/zsh/site-functions ]]; then
  fpath=(/usr/share/zsh/site-functions $fpath)
fi
if [[ -d /usr/local/share/zsh/site-functions ]]; then
  fpath=(/usr/local/share/zsh/site-functions $fpath)
fi
compinit
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

