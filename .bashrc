# ~/.bashrc; executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

## Variables -----------------------------------------------------------------
export GOPATH=$HOME/go
export PATH="$GOPATH:/opt/local/bin:/opt/local/sbin:/usr/sbin:/sbin:/usr/bin:/bin:/Library/Apple/usr/bin:/usr/local/sbin:/usr/local/bin"

export PAGER='less -m'
export EDITOR='vim'
export VISUAL=$EDITOR
export CDPATH='.:~:/Volumes/code'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
export CLICOLOR=1

# BSD ls Support
export LSCOLORS="ExFxBxDxCxegedabagacad"

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

# Complete Hosts
shopt -s hostcomplete

# Expand Aliases for Security
shopt -s expand_aliases

# Disable Core Dumps
ulimit -c 0

# Load Aliases
[ -r ~/.bash_aliases ] && source ~/.bash_aliases


## Completion ------------------------------------------------------------------
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    source /opt/local/etc/profile.d/bash_completion.sh
fi

if [ -f /opt/local/share/git/contrib/completion/git-completion.bash ]; then
    source /opt/local/share/git/contrib/completion/git-completion.bash
fi

if [ -f /opt/local/share/git/contrib/completion/git-prompt.sh ]; then
    source /opt/local/share/git/contrib/completion/git-prompt.sh
fi

if [ $(command -v gopass) ]; then
    source <(gopass completion bash)
fi

## Prompt ----------------------------------------------------------------------
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
PROMPT_COMMAND='__git_ps1 "[\e[34m\u\e[39m@\e[33m\h\e[39m][\e[34m\W\e[39m]" "\n\\\$ "'
