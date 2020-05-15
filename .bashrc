# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -laFo'
alias rb='source ~/.bashrc'
alias P='sudo pacman'
alias I='P -S'
alias emi3='em ~/.config/i3/config'
alias emt='emacs -nw'
alias emb='em ~/.bashrc'
alias agda='agda --compile-dir=~/agda/compiled'

export PATH=$PATH:/sbin
export PATH=$PATH:~/.local/bin
export PS1='\[\e[38;5;198m\]\w\[\e[m\]\[\e[38;5;14m\]$\[\e[m\] '

em() {
  emacs "$1" >/dev/null 2>&1 &
}

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
