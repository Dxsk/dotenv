DOTENV_DIR := $(shell cd "$(dir $(abspath $(lastword $(MAKEFILE_LIST))))" && pwd)
STOW := stow -t $(HOME) -d $(DOTENV_DIR)

.PHONY: install uninstall reinstall check

install:
	$(STOW) --verbose=1 .

uninstall:
	$(STOW) -D --verbose=1 .

reinstall:
	$(STOW) -R --verbose=1 .

check:
	$(STOW) --no --verbose=1 .
