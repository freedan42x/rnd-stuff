export PATH=/sbin:$PATH
export PATH=/usr/sbin:$PATH
export PATH=/home/bredor/.local/bin:$PATH
export PATH=/home/bredor/.cabal/bin:$PATH

export DOTNET_CLI_TELEMETRY_OPTOUT=1

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

em() {
  emacs "$1" >/dev/null 2>&1 &
}

mkcd() {
  mkdir -p "$1"
  cd "$1"  
}

alias py=python3
alias mypy="mypy --strict"

# Turn off system beep
xset b off
xset b 0 0 0

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
