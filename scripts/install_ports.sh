#!/usr/bin/env zsh

## Ensure we have the latest ports tree
sudo port selfupdate

## Declare our array of packages we need
PORTS=(tectonic exa fzf git-delta git go zsh hugo shellcheck tree pv sqlite3 postgresql12 ripgrep watch jq nodejs14 xz pandoc fd
fossil fping wget curl vault terraform-0.13 packer chruby ruby-install tmux tmux-pasteboard gnupg2 paperkey pinentry-mac
zshdb zsh-completions zsh-autosuggestions zsh-syntax-highlighting starship python37 py37-pip py37-ansible port_cutleaves
emacs-app multimarkdown)

## Install our packages
for port in $PORTS; do
  sudo port -N install $port
done

## Set defaults
sudo port select --set ansible py37-ansible
sudo port select --set python python37
sudo port select --set python3 python37
sudo port select --set pip pip37
sudo port select --set pip3 pip37
sudo port select --set terraform terraform0.13
