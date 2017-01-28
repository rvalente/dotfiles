# Dotfiles

The idea here is to eliminate as much pre-work required to get up and running on macOS.

Installs the environment I use on a daily basis, feel free to fork and open a PR.

### Packages

Homebrew packages that are included are:

  * git
  * go
  * xz
  * wget
  * bash-completion
  * packer
  * hub
  * vim
  * shellcheck
  * tree

Python packages that are installed/upgraded from pip are:

  * pip
  * setuptools
  * ansible

## Installation

### Prerequisites

Ensure you have Homebrew installed

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Once installed, simply run `make install` and you will have the dotfiles deployed.

## Recommendations

I highly recommend getting a newer version of bash installed.

```
# Install Non Ancient Bash
brew install bash

# Now ensure your Mac is configured to use the new shell.
echo "/usr/local/bin/bash" | sudo tee -a /etc/shells

# Now set your default shell to bash
chsh -s /usr/local/bin/bash
```

Ensure you close your active terminal window after you change your shell.

## Fonts

Run `make fonts` to install the Hack font into `~/Library/Fonts/`.

## iTerm Colors

I personally prefer the `base16-ocean.dark.256`, in order to use it, type `Cmd-,` in `iTerm2.app` and then go to `Profile > Colors > Color Presets... > Import` and navigate to the repo and import the colorscheme.

## Credits

Makefile Awesome-ness: https://github.com/b4b4r07/dotfiles
