# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. /home/bredor/.nix-profile/etc/profile.d/nix.sh

alias ls='ls --color=auto'
alias ll='ls -laFo'
alias rb='source ~/.bashrc'
alias P='sudo pacman'
alias I='P -S'
alias emi3='em ~/.config/i3/config'
alias emt='emacs -nw'
alias emb='em ~/.bashrc'
alias py=python

export PATH=$PATH:/sbin
export PATH=$PATH:~/.local/bin

function nix_shell_prompt() {
  if [ -z "$IN_NIX_SHELL" ]; then
    export PS1='\[\e[38;5;129m\]\w\[\e[m\]\[\e[38;5;182m\]$\[\e[m\] '
  else	
    export PS1='\[\e[38;5;129m\]\w\[\e[m\]\[\e[38;5;46m\]$\[\e[m\] '
  fi
}
PROMPT_COMMAND=nix_shell_prompt

em() {
  emacs "$1" >/dev/null 2>&1 &
}

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
