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
    # Paths vary by distro:
    #   Fedora:       /usr/share/fzf/shell/key-bindings.zsh
    #   Arch:         /usr/share/fzf/key-bindings.zsh
    #   Debian/Ubuntu:/usr/share/doc/fzf/examples/key-bindings.zsh
    #   Manual/Homebrew: ~/.fzf.zsh
    local fzf_keybindings=(
        /usr/share/fzf/shell/key-bindings.zsh      # Fedora
        /usr/share/fzf/key-bindings.zsh            # Arch
        /usr/share/doc/fzf/examples/key-bindings.zsh  # Debian/Ubuntu
        ~/.fzf.zsh                                  # Manual install / Homebrew
        /opt/homebrew/opt/fzf/shell/key-bindings.zsh  # macOS ARM Homebrew
        /usr/local/opt/fzf/shell/key-bindings.zsh     # macOS Intel Homebrew
    )

    for fzf_file in "${fzf_keybindings[@]}"; do
        if [[ -f "$fzf_file" ]]; then
            source "$fzf_file"
            break
        fi
    done

fi
