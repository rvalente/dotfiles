# ~/.bash_aliases

# Magic Dotfile Management Alias
alias gitdf='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Sysadmin Aliases
alias ls='ls -G'
alias ll='ls -Glah'
alias h=history
alias ps='/bin/ps auxww'
alias psg='/bin/ps auxww | grep'
alias tf='tail -f'

# Git Aliases
alias gs='git status -sb'
alias ga='git add -A'
alias gcv='git commit -v'
alias gcm='git commit -m'

# macOS Specific Aliases
alias brewu="brew update && brew upgrade && brew doctor && brew cleanup"
alias flushdns='sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache'

# Load Functions
[ -r ~/.functions ] && source ~/.functions

# Load User Aliases
[ -r ~/.bash_aliases.local ] && source ~/.bash_aliases.local
