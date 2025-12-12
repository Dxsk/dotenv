#!/usr/bin/env zsh
# ─────────────────────────────────────────────────────────────────────────────────
#                           FZF - Fuzzy Finder Configuration
# ─────────────────────────────────────────────────────────────────────────────────

# Only configure if fzf is installed
if (( $+commands[fzf] )); then

    # Default options (Custom Kanagawa x Gruvbox theme)
    export FZF_DEFAULT_OPTS="
      --height 40%
      --layout=reverse
      --border
      --info=inline
      --color=bg+:#363646,bg:#1f1f28,spinner:#ff7733,hl:#ff5d62
      --color=fg:#dcd7ba,header:#ff5d62,info:#c678dd,pointer:#ff7733
      --color=marker:#ff79c6,fg+:#dcd7ba,prompt:#d8a657,hl+:#ff7733
    "

    # Ctrl+R for history search with fzf
    export FZF_CTRL_R_OPTS="
      --preview 'echo {}'
      --preview-window down:3:wrap
      --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort'
    "

    # Load fzf keybindings (Ctrl+R for history, Ctrl+T for files, Alt+C for cd)
    if [[ -f /usr/share/fzf/shell/key-bindings.zsh ]]; then
        source /usr/share/fzf/shell/key-bindings.zsh
    elif [[ -f ~/.fzf.zsh ]]; then
        source ~/.fzf.zsh
    fi

fi
