# Dotfiles

## Disclaimer

This is designed to bootstrap a clean install of macOS Sierra quickly.
It will overwrite all the things in your homedir with symlinks!

## Installation

```
# Clone Repo to .dotfiles
git clone https://github.com/rvalente/dotfiles.git ~/.dotfiles
# Install Dotfiles
cd ~/.dotfiles && ./install.sh
```

## After Installation

Ensure you create a `~/.gitconfig.local` file with your username/email.
You do not want to have this located within the `.dotfiles` repo!

```
[user]
	name = GIT_NAME
	email = GIT_EMAIL
[github]
	user = GITHUB_USERNAME
	token = GITHUB_TOKEN
```

## Customization

If you want to tweak/customize you can create a `~/.DOTFILE.local` file, this will get loaded at the end of the main file.

For example, if you want to add some aliases to your setup, create a `~/.bash_aliases.local` file with all the aliases that you want.
