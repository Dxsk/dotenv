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
