#!/usr/bin/env zsh
# ─────────────────────────────────────────────────────────────────────────────────
#                           HEX COLOR PREVIEW
# ─────────────────────────────────────────────────────────────────────────────────
# Function to display a hex color preview
# Usage: color #cba6f7 or color cba6f7

color() {
    local hex="${1#\#}"

    # Validate hex format
    if [[ ! "$hex" =~ ^[0-9a-fA-F]{6}$ ]]; then
        print -P "%F{red}Invalid hex color: $1%f" >&2
        return 1
    fi

    local -i r=$((16#${hex:0:2}))
    local -i g=$((16#${hex:2:2}))
    local -i b=$((16#${hex:4:2}))

    printf '\e[48;2;%d;%d;%dm    \e[0m #%s\n' "$r" "$g" "$b" "$hex"
}

# Display multiple colors
colors() {
    local c
    for c in "$@"; do
        color "$c"
    done
}

# Quick Catppuccin Mocha palette
catppuccin() {
    print "Catppuccin Mocha:"
    color "cba6f7"  # Mauve
    color "f38ba8"  # Red
    color "a6e3a1"  # Green
    color "f9e2af"  # Yellow
    color "89b4fa"  # Blue
    color "f5c2e7"  # Pink
    color "94e2d5"  # Teal
    color "cdd6f4"  # Text
}
