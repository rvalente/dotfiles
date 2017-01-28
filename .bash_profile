# ~/.bash_profile

# Ensure we're using Vim!
export EDITOR=vim
export VISUAL=vim
export PAGER='less -m'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color

# Enable Colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Setup Go Environment
export GOPATH=$HOME/go
export PATH=$HOME/bin:$PATH:$GOPATH/bin

# Enable Homebrew Completion
[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion

# Load Secrets
[ -r ~/.secrets ] && source ~/.secrets

# Run our Interactive Shell bashrc
[ -r ~/.bashrc ] && source ~/.bashrc
