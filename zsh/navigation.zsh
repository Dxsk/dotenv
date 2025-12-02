#!/usr/bin/env zsh
# ─────────────────────────────────────────────────────────────────────────────────
#                           DIRECTORY NAVIGATION
# ─────────────────────────────────────────────────────────────────────────────────
# Auto-save current directory on each cd
# New terminals automatically open in the last visited directory

# Configuration
typeset -g LASTDIR_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/lastdir"
typeset -ga DIRHISTORY=()
typeset -gi DIRHISTORY_MAX=50

# Ensure cache directory exists
[[ -d "${LASTDIR_FILE:h}" ]] || mkdir -p "${LASTDIR_FILE:h}"

# Save current directory function
_save_lastdir() {
    print -r -- "$PWD" >| "$LASTDIR_FILE"
}

# Save to history on each cd
_save_dirhistory() {
    # Avoid consecutive duplicates and empty entries
    if [[ -n "$OLDPWD" && ( ${#DIRHISTORY[@]} -eq 0 || "${DIRHISTORY[-1]}" != "$OLDPWD" ) ]]; then
        DIRHISTORY+=("$OLDPWD")
        # Keep max entries
        (( ${#DIRHISTORY[@]} > DIRHISTORY_MAX )) && shift DIRHISTORY
    fi
}

# Register hooks
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _save_lastdir
add-zsh-hook chpwd _save_dirhistory

# back command: return to previous directory in history
# Usage: back      → go to previous directory
#        back -a   → select with fzf
back() {
    case "$1" in
        -a|--all)
            # fzf mode: display reversed history (most recent on top)
            if (( ${#DIRHISTORY[@]} == 0 )); then
                print "History empty" >&2
                return 1
            fi

            if (( ! $+commands[fzf] )); then
                print "fzf not installed" >&2
                return 1
            fi

            local target
            target=$(print -l "${(Oa)DIRHISTORY[@]}" | fzf --prompt="cd → ")

            if [[ -n "$target" ]]; then
                if [[ -d "$target" ]]; then
                    builtin cd -- "$target" && print "→ $target"
                else
                    print "Directory no longer exists: $target" >&2
                    return 1
                fi
            fi
            ;;

        -h|--help)
            print "Usage: back [OPTION]"
            print "  back      Go to previous directory in history"
            print "  back -a   Select directory from history with fzf"
            print "  back -h   Show this help"
            ;;

        "")
            # Normal mode: go to previous
            if (( ${#DIRHISTORY[@]} > 0 )); then
                local target="${DIRHISTORY[-1]}"
                DIRHISTORY[-1]=()  # Remove last (zsh idiom)

                if [[ -d "$target" ]]; then
                    builtin cd -- "$target" && print "← $target"
                else
                    print "Directory no longer exists: $target" >&2
                    back  # Try next one recursively
                fi
            else
                print "History empty" >&2
                return 1
            fi
            ;;

        *)
            print "Unknown option: $1" >&2
            print "Use 'back -h' for help" >&2
            return 1
            ;;
    esac
}

# On startup: go to last directory if starting from $HOME
if [[ "$PWD" == "$HOME" && -r "$LASTDIR_FILE" ]]; then
    local _lastdir
    _lastdir="$(<"$LASTDIR_FILE")"
    [[ -d "$_lastdir" ]] && builtin cd -- "$_lastdir"
fi
