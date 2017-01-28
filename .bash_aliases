# Sysadmin Aliases
alias ls='ls -GF'
alias ll='ls -GFlah'
alias h=history
alias ps='ps auxww'
alias psg='ps aux | grep'
alias tf='tail -f'

# Hub Integration
eval "$(hub alias -s)"

# macOS Aliases
alias brewu="brew update && brew upgrade && brew doctor && brew cleanup"
alias flushdns='sudo killall -HUP mDNSResponder'