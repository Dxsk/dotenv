#!/usr/bin/env zsh
# ─────────────────────────────────────────────────────────────────────────────────
#                           NVM - Node Version Manager
# ─────────────────────────────────────────────────────────────────────────────────

export NVM_DIR="${XDG_DATA_HOME:-$HOME}/.nvm"

# Load nvm if installed
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"

    # Load bash completion (compatible with zsh)
    [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

    # Use LTS version by default (silently)
    nvm use --lts --silent 2>/dev/null
fi
