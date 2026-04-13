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

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# Restore last directory
typeset -g _LASTPOS_ENABLED=true
[[ -f ~/.lastpos ]] && cd "$(cat ~/.lastpos)" 2>/dev/null
chpwd() { $_LASTPOS_ENABLED && pwd > ~/.lastpos }
lp.stop() { _LASTPOS_ENABLED=false; echo "lastpos paused" }
lp.rec() { _LASTPOS_ENABLED=true; pwd > ~/.lastpos; echo "lastpos recording" }

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
dot() {
  echo "\033[1;33m===\033[0m Dotenv \033[1;33mupdate\033[0m \033[1;33m===\033[0m"
  echo "  \033[0;36mSource:\033[0m $DOTENV_DIR"
  echo "  \033[0;36mTarget:\033[0m $HOME"
  echo ""
  local changes=0
  (cd "$DOTENV_DIR" && stow -t "$HOME" --restow --verbose=1 .) 2>&1 | while read -r line; do
    if [[ "$line" == *LINK:* ]]; then
      local file="${line##*LINK: }"
      echo "  \033[0;32m+\033[0m \033[0;36mLINK\033[0m \033[0;37m$file\033[0m"
    elif [[ "$line" == *UNLINK:* ]]; then
      local file="${line##*UNLINK: }"
      echo "  \033[0;31m-\033[0m \033[0;33mUNLINK\033[0m \033[0;90m$file\033[0m"
    else
      echo "  $line"
    fi
  done
  echo ""
  source ~/.zshrc 2>/dev/null
  echo "\033[1;33m===\033[0m Done. \033[0;32mShell reloaded.\033[0m"
}

# Auto-load/unload sourceme files
source ~/.config/zsh/sourceme.zsh
