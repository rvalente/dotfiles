# ~/.zshrc
#
# Global Order: zshenv > [zprofile] > zshrc > [zlogin]

eval "$(starship init zsh)"

## ZSH Plugins ---------------------------------------------------------------
source /opt/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## History -------------------------------------------------------------------
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

autoload -Uz compinit && compinit

## Options -------------------------------------------------------------------
setopt appendhistory        #
setopt sharehistory         # share history across shells
setopt histignorealldups    # Remove older duplicate history items
setopt histverify           # perform history expansion and reload the line into the editing buffer
setopt extendedhistory      # Save each command’s beginning timestamp
setopt autocd               # use 'cd x' if 'x' is run and is not a command
setopt automenu             # show completion menu on succesive tab press
setopt promptsubst          # Allow for functions in the prompt.
setopt extendedglob         # Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns
setopt nomatch              #
setopt notify               #
setopt alwaystoend          # cursor is moved to the end of the word with completion
setopt clobber              # allow clobbering with >, no need to use >!
setopt interactivecomments  # allow comments, even in interactive shells
setopt completealiases      # Prevents aliases on the command line from being internally substituted
setopt ignoreeof            # Do not exit on end-of-file.

unsetopt correct correctall # Try to correct the spelling of commands.
unsetopt beep               # No beeps on error
unsetopt MULTIBYTE

## cdpath --------------------------------------------------------------------
cdpath=(
  $HOME/code
)

## Aliases -------------------------------------------------------------------
alias cat='bat'
alias ls='exa'
alias ll='exa -lbF --git'
alias lt='exa --tree --level=2'
alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gb='git branch'
alias gcv='git commit -v'
alias gcm='git commit -m'
alias gp='git push'
alias gd='git diff'
alias gco='git checkout'
alias gh='$(git remote -v 2> /dev/null | grep github | sed -e "s/.*git\:\/\/\([a-z]\.\)*/\1/" -e "s/\.git.*//g" -e "s/.*@\(.*\)$/\1/g" | tr ":" "/" | tr -d "\011" | sed -e "s/^/open http:\/\//g" | uniq)'
alias tf='tail -f'
alias psg='ps auxww | grep'
alias gitdf='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias flushdns='sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache'

# Helper Aliases
alias grep='grep --color=auto' # Always highlight grep search term
alias ping='ping -c 5'         # Pings with 5 packets, not unlimited
alias df='df -h'               # Disk free, in gigabytes, not bytes
alias du='du -h -c'            # Calculate total disk usage for a folder

## Better ZSH History --------------------------------------------------------
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

## Key Bindings ---------------------------------------------------------------
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

## Chruby ---------------------------------------------------------------------
source /opt/local/share/chruby/chruby.sh
source /opt/local/share/chruby/auto.sh
