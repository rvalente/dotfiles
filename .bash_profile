# Ensure we're using Vim!
export EDITOR=vim
export VISUAL=vim
export PAGER='less -m'

# Setup Colored Term
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Setup Go Environment
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Load Bash Completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Load Aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Load the .bashrc
[ -r ~/.bashrc ] && source ~/.bashrc