# Ensure we're using Vim!
export EDITOR=vim
export VISUAL=vim
export PAGER='less -m'

# Enable Colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Setup Go Environment
export GOPATH=$HOME/go
export PATH=$HOME/bin:$PATH:$GOPATH/bin

# Load Bash Completion
[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion

# Load the .secrets
[ -r ~/.secrets ] && source ~/.secrets

# Load the .bashrc
[ -r ~/.bashrc ] && source ~/.bashrc