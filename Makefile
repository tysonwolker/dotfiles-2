all: symlink homebrew node python iterm osx

setup:
	@./script/setup

symlink:
	@./script/symlink

homebrew:
	@sh ./homebrew/homebrew.sh

node:
	@sh ./node/packages.sh

python:
	@sh ./python/packages.sh

iterm:
	@sh ./iterm2/themes.sh

osx:
	@source ~/.osx

.PHONY: symlink homebrew node python iterm osx