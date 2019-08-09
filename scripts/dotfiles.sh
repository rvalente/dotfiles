#!/bin/bash

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
BREWFILE="${HOME}/.Brewfile"

## Main ----------------------------------------------------------------------

# Check for Homebrew and install if we don't have it
if test ! "$(command -v brew)"; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Turn off Homebrew Analytics; Before we do anything else!
brew analytics off

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle

# Check if we have a custom brewfile
echo "Checking for custom Brewfile at .Brewfile.local"
if [ -f "${HOME}/.Brewfile.local" ]; then
  BREWFILE="$HOME/.Brewfile.local"
fi

# Install User Packages
echo "Install Packages from ${BREWFILE}..."
brew bundle --file="$BREWFILE"

# Install Plist to LaunchAgents
if [ ! -f ~/Library/LaunchAgents/gnu.emacs.daemon.plist ]; then
    cp gnu.emacs.daemon.plist ~/Library/LaunchAgents/gnu.emacs.daemon.plist
fi

# Enable Emacs Daemon
if [ -f ~/Library/LaunchAgents/gnu.emacs.daemon.plist ]; then
    launchctl load -w ~/Library/LaunchAgents/gnu.emacs.daemon.plist
fi

# Setup GPG Agent
echo "Add this to ~/.gnupg/gpg-agent.conf"
echo "pinentry-program /usr/local/bin/pinentry-mac"
echo "Add this to ~/.gnupg/gpg.conf"
echo "keyserver hkps://hkps.pool.sks-keyservers.net"
