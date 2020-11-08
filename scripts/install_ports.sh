#!/usr/bin/env bash

## Ensure we have the latest ports tree
sudo port selfupdate

## Declare our array of packages we need
PORTS=(git-delta git go shellcheck tree pv sqlite3 postgresql13-server
postgresql13 watch jq nodejs15 xz fping wget curl vault terraform-0.13
packer tmux tmux-pasteboard gnupg2 paperkey pinentry-mac python38 py38-pip
bash go-migrate gopass py38-ansible port_cutleaves multimarkdown hugo gh
bash-completion vim emacs-mac-app)

## Install our packages
for port in ${PORTS[@]}; do
  sudo port -N install $port
done

## Set defaults
sudo port select --set ansible py38-ansible
sudo port select --set python python38
sudo port select --set python3 python38
sudo port select --set pip pip38
sudo port select --set pip3 pip38
sudo port select --set terraform terraform0.13

## Update Default Shell
sudo sh -c 'grep -qxF "/opt/local/bin/bash" /etc/shells' || sudo sh -c 'echo "/opt/local/bin/bash" >> /etc/shells'

# Set Default Shell
chsh -s '/opt/local/bin/bash' $(whoami)
