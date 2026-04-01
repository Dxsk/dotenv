# CachyOS base config
source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.local/bin:$PATH"
export TERM="xterm-256color"

# Restore last directory
typeset -g _LASTPOS_ENABLED=true
[[ -f ~/.lastpos ]] && cd "$(cat ~/.lastpos)" 2>/dev/null
chpwd() { $_LASTPOS_ENABLED && pwd > ~/.lastpos }
lp.stop() { _LASTPOS_ENABLED=false; echo "lastpos paused" }
lp.rec() { _LASTPOS_ENABLED=true; pwd > ~/.lastpos; echo "lastpos recording" }

# Zoxide init
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
