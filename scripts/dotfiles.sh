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
if test ! "$(command -v port)"; then
  echo "Macports not installed, exiting"
  exit 1
fi

# Setup GPG Agent
echo "Add this to ~/.gnupg/gpg-agent.conf"
echo "pinentry-program /usr/local/bin/pinentry-mac"
echo "Add this to ~/.gnupg/gpg.conf"
echo "keyserver hkps://hkps.pool.sks-keyservers.net"
