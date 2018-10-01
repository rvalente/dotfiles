# ~/.bash_aliases

# Magic Dotfile Management Alias
alias gitdf='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Show Type, List Files, All Files, Human Readable, and Show Flags
alias ll='ls -F -l -a -h -O'

# Fully Qualify PS to Override Default Flags
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
