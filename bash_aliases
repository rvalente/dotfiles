# ~/.bash_aliases

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
alias flushdns='sudo killall -HUP mDNSResponder'

# Functions
pman() {
  man -t "${1}" | open -f -a /Applications/Preview.app
}

# Load User Aliases
[ -r ~/.bash_aliases.local ] && source ~/.bash_aliases.local
