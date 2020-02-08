PS1="\n\[\e[1;32m\][$USER@\h:\w]\$\[\e[0m\] "

em() {
  emacs "$1" >/dev/null 2>&1 &
}
