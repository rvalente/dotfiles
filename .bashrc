# ~/.bashrc; executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

## Bash Completion -----------------------------------------------------------

# Enable Homebrew Completion
[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion

## Environment Variables -----------------------------------------------------

export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/Library/TeX/texbin/"

export EDITOR=vim
export VISUAL=$EDITOR
export PAGER='less -m'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
export CLICOLOR=1

# BSD ls Support
export LSCOLORS="ExFxBxDxCxegedabagacad"

# GNU ls Support
export LS_COLORS="di=1;34:ln=1;35:so=1;31:pi=1;33:ex=1;32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# Golang Support
export GOPATH=~/code/go
export PATH=$PATH:$GOPATH/bin

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

## History -------------------------------------------------------------------

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null

# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null

# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
CDPATH="$HOME/code"

# Complete Hosts
shopt -s hostcomplete

# Expand Aliases for Security
shopt -s expand_aliases

# Disable Core Dumps
ulimit -c 0

# Load Aliases
[ -r ~/.bash_aliases ] && source ~/.bash_aliases

# Prompt ---------------------------------------------------------------------
# Leverage the Built In Git Functionality
# /usr/local/etc/bash_completion.d/git-prompt.sh
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
PROMPT_COMMAND='__git_ps1 "[\e[34m\u\e[39m@\e[33m\h\e[39m][\e[34m\W\e[39m]" "\n\\\$ "'

# Ruby / Chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# check if ruby 2.6.2 and source
[ -d ~/.rubies/ruby-2.6.2 ] && chruby ruby-2.6.2
