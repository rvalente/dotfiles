#!/usr/bin/env bash

## Shell Opts ----------------------------------------------------------------
# Exit on any non-zero exit code
set -o errexit

# Exit on any unset variable
set -o nounset

# Pipeline's return status is the value of the last (rightmost) command
# to exit with a non-zero status, or zero if all commands exit successfully.
set -o pipefail

# Enable tracing
set -o xtrace

## Variables -----------------------------------------------------------------
DOTFILES="$(cd "$(dirname "$0")" && pwd -P)"
BREWFILE="${DOTFILES}/Brewfile"

## Main ----------------------------------------------------------------------

# Check for Homebrew and install if we don't have it
if test ! "$(which brew)"; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Turn off Homebrew Analytics; Before we do anything else!
brew analytics off

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle

# Check if we have a custom brewfile
if [ -f "${HOME}/.Brewfile" ]; then
  BREWFILE="$HOME/.Brewfile"
fi

# Install User Packages
echo "Install Packages from ${BREWFILE}..."
brew bundle --file="$BREWFILE"

# Set Newer Bash as Default Shell
CURRENTSHELL=$(dscl . -read /Users/"$USER" UserShell | awk '{print $2}')
if [[ "$CURRENTSHELL" != "/usr/local/bin/bash" ]]; then
  sudo dscl . -change /Users/"$USER" UserShell "$SHELL" /usr/local/bin/bash > /dev/null 2>&1
fi

# List of Dotfiles
declare -a FILES_TO_SYMLINK=(
  'bash_aliases'
  'bash_profile'
  'bashrc'
  'functions'
  'gemrc'
  'gitconfig'
  'gitignore'
  'gitmessage'
  'iterm2_integration'
  'inputrc'
  'tmux.conf'
  'vimrc'
)

# Symlink Dotfiles
for file in "${FILES_TO_SYMLINK[@]}"; do
  sourceFile="$DOTFILES/$file"
  targetFile="$HOME/.$file"

  if [ ! -e "$targetFile" ]; then
    ln -sf "$sourceFile" "$targetFile"
  fi
done

unset FILES_TO_SYMLINK

# Symlink Dotfile vim Dir
if [ -d "${HOME}/.vim" ]; then
  # Directory Exists, Check if Symlink
  if [ ! -L "${HOME}/.vim" ]; then
    # It is not a symlink, get rid of it!
    mv "${HOME}/.vim" "${HOME}/.vim.old"
    ln -sf "${DOTFILES}/vim" "${HOME}/.vim"
  fi
else
  ln -sf "${DOTFILES}/vim" "${HOME}/.vim"
fi

# Symlink ssh_config
ln -sf "$DOTFILES"/ssh_config "$HOME"/.ssh/config

# Install the iTerm2 Color Scheme
echo "To Install iTerm2 Colorscheme run the following in iTerm2..."
echo "open $DOTFILES/iterm2/base16-ocean.dark.256.itermcolors"

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Reload our Shell
exec bash --login
