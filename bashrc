# ~/.bashrc; executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of the LINES and COLUMNS.
shopt -s checkwinsize

# Complete Hosts
shopt -s hostcomplete

# Example Aliases for Security
shopt -s expand_aliases

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Disable Core Dumps
ulimit -c 0

# Support Awesome cdpath
export CDPATH=.:$HOME/code

# Load Aliases
[ -r ~/.bash_aliases ] && source ~/.bash_aliases

# Setup Git Prompt Variables
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
source "$(brew --prefix)/etc/bash_completion.d/git-prompt.sh"

# Set Prompt
export PS1="[\[$(tput sgr0)\]\[\033[38;5;4m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]][\[$(tput sgr0)\]\[\033[38;5;6m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\]]\\$ \[$(tput sgr0)\]"
