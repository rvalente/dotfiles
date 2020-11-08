# ~/.bash_aliases

alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gb='git branch'
alias gcv='git commit -v'
alias gcm='git commit -m'
alias gp='git push'
alias gd='git diff'
alias gco='git checkout'
alias tf='tail -f'
alias psg='ps auxww | grep'
alias gitdf='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias flushdns='sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache'

# Show Type, List Files, All Files, Human Readable, and Show Flags
alias ll='ls -F -l -a -h -O'

# Helper Aliases
alias grep='grep --color=auto' # Always highlight grep search term
alias df='df -h'               # Disk free, in gigabytes, not bytes
alias du='du -h -c'            # Calculate total disk usage for a folder
