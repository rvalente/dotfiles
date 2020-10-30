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

## Main ----------------------------------------------------------------------
# Check for Homebrew and install if we don't have it
if test ! "$(command -v port)"; then
  echo "Install MacPorts"
  exit 1
fi

# Setup GPG Agent
cat <<EOF > ~/.gnupg/gpg-agent.conf
pinentry-program /Applications/MacPorts/pinentry-mac.app/Contents/MacOS/pinentry-mac
EOF

killall gpg-agent || true
