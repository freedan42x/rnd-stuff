PS1="\n\[\e[1;32m\][$USER@\h:\w]\$\[\e[0m\] "

em() {
  emacs "$1" >/dev/null 2>&1 &
}

mkcd() {
  mkdir -p "$1"
  cd "$1"  
}
