#!/usr/bin/env bash

## Shell Opts ----------------------------------------------------------------
set -e -u -x

## Variables -----------------------------------------------------------------
DOTFILES="$HOME/.dotfiles"
BREWFILE="$HOME/.dotfiles/Brewfile"

## Main ----------------------------------------------------------------------

# Check for Homebrew and install if we don't have it
if test ! "$(which brew)"; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle

# TODO: Support Custom-User Brewfile so anyone can bring their own apps
brew bundle --file="${BREWFILE}"

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
  'gemrc'
  'gitconfig'
  'gitignore'
  'gitmessage'
  'inputrc'
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

# Symlink Dotfile Bin Dir
ln -sf "$DOTFILES"/bin "$HOME"/

# Install Hack Font
cp "$DOTFILES"/fonts/*.ttf "$HOME"/Library/Fonts/

# Install the iTerm2 Color Scheme
echo "To Install iTerm2 Colorscheme run the following in iTerm2..."
echo "open $DOTFILES/iterm2/base16-ocean.dark.256.itermcolors"

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Reload our Shell
exec bash --login
