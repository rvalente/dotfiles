# ~/.zshenv
#
# Global Order: zshenv > [zprofile] > zshrc > [zlogin]

# Use Vim as VISUAL and EDITOR
export PAGER='less -m'
export EDITOR='vim'
export VISUAL=$EDITOR
export GOPATH=~/go
export PATH="$GOPATH/bin:/usr/local/bin:/usr/local/sbin:$PATH"
