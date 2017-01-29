# ~/.bash_profile; executed by bash(1) for login shells.


# Ensure we're using Vim!
export EDITOR=vim
export VISUAL=vim
export PAGER='less -m'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color

# Enable Colors
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Setup Go Environment
export GOPATH=$HOME/go
export PATH=$HOME/bin:$PATH:$GOPATH/bin

# Enable Homebrew Completion
[ -r /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion

# Load Local Bash Profile
[ -r ~/.bash_profile.local ] && source ~/.bash_profile.local

# Run our Interactive Shell bashrc
[ -r ~/.bashrc ] && source ~/.bashrc
