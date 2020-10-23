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
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
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

# Setup GPG Agent
cat <<EOF > ~/.gnupg/gpg-agent.conf
pinentry-program /usr/local/bin/pinentry-mac
EOF

killall gpg-agent || true

# Link to /Applications
ln -sf /usr/local/opt/emacs-plus@27/Emacs.app /Applications

# Start services on boot
brew services start d12frosted/emacs-plus/emacs-plus@27
brew services start postgresql
brew services list
