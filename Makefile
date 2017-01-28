DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitmodules fonts iterm2
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
BREW       := $(shell command -v brew 2> /dev/null)

.DEFAULT_GOAL := help

all:

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

install: update pkgs link ## Run make update, link
	@exec $$SHELL

link: ## Link Dotfiles in Home Directory
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

update: ## Fetch changes for this repo
	git pull origin master

pkgs: ## Install Required Homebrew Packages
ifndef BREW
	$(error "brew is not available please install homebrew")
endif
	brew install go git xz pt wget bash bash-completion packer hub htop vim python shellcheck tree fasd
	pip install --upgrade pip setuptools python-openstackclient ansible pep8

fonts: ## Install Fonts
	cp fonts/*.ttf ~/Library/Fonts/

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'