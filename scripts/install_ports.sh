#!/usr/bin/env zsh

## Ensure we have the latest ports tree
sudo port selfupdate

## Declare our array of packages we need
PORTS=(git-delta git go zsh shellcheck tree pv sqlite3 postgresql13-server
postgresql13 watch jq nodejs15 xz fping wget curl vault terraform-0.13
packer tmux tmux-pasteboard gnupg2 paperkey pinentry-mac python38 py38-pip
go-migrate gopass py38-ansible port_cutleaves emacs-mac-app multimarkdown
hugo gh iterm2 nomad docker docker-machine)

## Install our packages
for port in $PORTS; do
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
sudo sh -c 'echo /opt/local/bin/zsh >>/etc/shells'
chsh -s '/opt/local/bin/zsh' $(whoami)
