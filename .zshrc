# Powerlevel10k instant prompt (doit rester tout en haut)
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh plugins
plugins=(
  git
  fzf
  extract
  sudo              # Double ESC = prepend sudo
  archlinux          # Pacman/yay aliases
  colored-man-pages  # Colored man pages
  copypath           # Copy current path
  copybuffer         # Ctrl+O = copy line
  dirhistory         # Alt+arrows = navigate directories
  fancy-ctrl-z       # Ctrl+Z = toggle fg/bg
  aliases            # 'acs' command to list aliases
  web-search         # 'google ...' from terminal
  eza                # ls -> eza aliases
  zoxide             # Smart cd (z, zi)
  thefuck            # ESC ESC = fix last command
  tldr               # tldr completion
  dotenv             # Auto-source .env on cd
  wd                 # Warp directories (wd add, wd list, wd <name>)
)

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

# Aliases
alias cat="bat --style=auto"
alias ocat="/usr/bin/cat"
alias ols="/usr/bin/ls --color"
alias oll="/usr/bin/ls -lart --color"
alias ll="exa -lar"
alias find="fd"
alias du="dust"
alias top="btop"
alias diff="diff --color=auto"
alias gid="git-identity"

# Dotfiles management
export DOTENV_DIR="${DOTENV_DIR:-$HOME/Documents/github.com/Dxsk/dotenv}"
alias dot="cd $DOTENV_DIR && stow -t ~ ."
alias dot-remove="cd $DOTENV_DIR && stow -D -t ~ ."

# Auto-load/unload sourceme files
source ~/.config/zsh/sourceme.zsh
