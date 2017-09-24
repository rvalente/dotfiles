# Dotfiles

## Disclaimer

This is designed to bootstrap a clean install of macOS Sierra quickly.
It will overwrite all the things in your homedir with symlinks!

## Submodules

Note: This configuration uses git submodules for plugins, please ensure that you update your submodules once you clone the repo!

## Installation

IMPORTANT: `cp Brewfile ../.Brewfile` if you want to customize the packages that are installed.

``` bash
# Clone Repo to .dotfiles
git clone https://github.com/rvalente/dotfiles.git ~/.dotfiles

# Install Dotfiles
cd ~/.dotfiles && ./install.sh
```

## After Installation

Ensure you create a `~/.gitconfig.local` file with your username/email.
You do not want to have this located within the `.dotfiles` repo!

``` ini
[user]
	name = GIT_NAME
	email = GIT_EMAIL

[github]
	user = GITHUB_USERNAME
	token = GITHUB_TOKEN
```

## Update Plugins

IMPORTANT: If this is the first time cloning the dotfiles down...

```
git submodule init
```

```
git submodule update --remote --merge
```

## Customization

If you want to tweak/customize you can create a `~/.DOTFILE.local` file, this will get loaded at the end of the main file.

For example, if you want to add some aliases to your setup, create a `~/.bash_aliases.local` file with all the aliases that you want.


## Credits

Thanks to [Smyck](http://color.smyck.org) for making a color scheme that doesn't suck.
