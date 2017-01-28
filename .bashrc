# ~/.bashrc: executed by bash(1) for non-login shells.

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

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Turn On FASD
eval "$(fasd --init auto)"

# Load Colors
[ -f ~/.bash_colors ] && source ~/.bash_colors

# Load Aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Turn on Git Prompt
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh

# Set Prompt
PROMPT_COMMAND='__git_ps1 "${Color_Off}[${Blue}\u${Color_Off}@${Yellow}\h${Color_Off}][\W]" "\\\$ "'