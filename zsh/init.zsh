# CachyOS base config
source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.local/bin:$PATH"
export TERM="xterm-256color"

# Restore last directory
[[ -f ~/.lastpos ]] && cd "$(cat ~/.lastpos)" 2>/dev/null
chpwd() { pwd > ~/.lastpos }

# Zoxide init
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
