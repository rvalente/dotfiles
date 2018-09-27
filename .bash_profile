# ~/.bash_profile; executed by bash(1) for login shells.

# Setup PATH, Homebrew first, sbin priority over bin
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"

# Enable Homebrew Completion
[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion

# Run our Interactive Shell bashrc
[ -r ~/.bashrc ] && source ~/.bashrc
