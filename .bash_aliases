# ~/.bash_aliases

# Sysadmin Aliases
alias ls='ls -GF'
alias ll='ls -GFlah'
alias h=history
alias ps='/bin/ps auxww'
alias psg='/bin/ps auxww | grep'
alias tf='tail -f'

# Git Aliases
alias gs='git status -sb'
alias ga='git add -A'
alias gcv='git commit -v'
alias gcm='git commit -m'

# macOS Aliases
alias brewu="brew update && brew upgrade && brew doctor && brew cleanup"
alias flushdns='sudo killall -HUP mDNSResponder'

# Load User Aliases
[ -f ~/.bash_aliases.local ] && source ~/.bash_aliases.local
