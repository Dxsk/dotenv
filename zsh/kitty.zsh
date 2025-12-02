#!/usr/bin/env zsh
# ─────────────────────────────────────────────────────────────────────────────────
#                        KITTY TERMINAL CONFIGURATION
# ─────────────────────────────────────────────────────────────────────────────────
# TERM compatibility for Kitty - allows apps to use xterm-kitty
# while maintaining compatibility with programs that only know xterm

if [[ "$TERM" == "xterm-kitty" ]]; then
    # SSH aliases - use xterm-256color to avoid issues on remote servers
    alias ssh='TERM=xterm-256color ssh'
    alias scp='TERM=xterm-256color scp'
    alias rsync='TERM=xterm-256color rsync'

    # Kitty shell integration (autocompletion, etc.)
    if (( $+commands[kitty] )); then
        autoload -Uz compinit && compinit -u
        kitty + complete setup zsh | source /dev/stdin
    fi
fi

# Useful Kitty aliases (only if kitty is available)
if (( $+commands[kitty] )); then
    alias icat='kitty +kitten icat'           # Display images in terminal
    alias kdiff='kitty +kitten diff'          # Diff with syntax highlighting
    alias kssh='kitty +kitten ssh'            # SSH with automatic terminfo transfer
    alias kclip='kitty +kitten clipboard'     # Clipboard management
fi
