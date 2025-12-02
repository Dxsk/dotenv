# Dotenv

![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat-square&logo=gnubash&logoColor=white)
![Zsh](https://img.shields.io/badge/Zsh-F15A24?style=flat-square&logo=zsh&logoColor=white)
![Vim](https://img.shields.io/badge/Vim-019733?style=flat-square&logo=vim&logoColor=white)
![Kitty](https://img.shields.io/badge/Kitty-000000?style=flat-square&logo=kitty&logoColor=white)
![GNOME](https://img.shields.io/badge/GNOME-4A86CF?style=flat-square&logo=gnome&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black)

Personal dotfiles and shell configurations.

## Features

- **Custom color theme** - Kanagawa x Gruvbox inspired dark theme with orange/red/violet accents
- **Zsh configurations** - Modular shell setup with useful functions and aliases
- **Directory navigation** - `back` command with history stack and fzf integration
- **Workstation aliases** - Shortcuts for dnf, systemd, podman, python venvs, and more
- **GNOME extension** - Focus highlight border for active windows

## Color Palette

| Color | Hex | Usage |
|-------|-----|-------|
| ![Background](https://img.shields.io/badge/-%231f1f28?style=flat-square&color=1f1f28) | `#1f1f28` | Background |
| ![Foreground](https://img.shields.io/badge/-%23dcd7ba?style=flat-square&color=dcd7ba) | `#dcd7ba` | Foreground |
| ![Red](https://img.shields.io/badge/-%23ff5d62?style=flat-square&color=ff5d62) | `#ff5d62` | Red |
| ![Orange](https://img.shields.io/badge/-%23ff7733?style=flat-square&color=ff7733) | `#ff7733` | Orange |
| ![Yellow](https://img.shields.io/badge/-%23d8a657?style=flat-square&color=d8a657) | `#d8a657` | Yellow |
| ![Green](https://img.shields.io/badge/-%2398bb6c?style=flat-square&color=98bb6c) | `#98bb6c` | Green |
| ![Blue](https://img.shields.io/badge/-%237fb4ca?style=flat-square&color=7fb4ca) | `#7fb4ca` | Blue |
| ![Violet](https://img.shields.io/badge/-%23c678dd?style=flat-square&color=c678dd) | `#c678dd` | Violet |
| ![Pink](https://img.shields.io/badge/-%23ff79c6?style=flat-square&color=ff79c6) | `#ff79c6` | Pink |

## Structure

```
dotenv/
├── install.sh                          # Installation script
├── gnome-extensions/
│   └── focus-highlight@custom/         # Window focus border extension
│       ├── extension.js
│       └── metadata.json
├── kitty/
│   └── theme.conf                      # Kitty terminal theme
├── vim/
│   └── colors/
│       └── kanagawa-gruvbox.vim        # Vim colorscheme
└── zsh/
    ├── colors.zsh                      # Hex color preview functions
    ├── fzf.zsh                         # Fzf configuration
    ├── kitty.zsh                       # Kitty terminal integration
    ├── navigation.zsh                  # Directory history & back command
    ├── nvm.zsh                         # Node Version Manager
    └── workstation.zsh                 # System aliases & functions
```

## Installation

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/dotenv.git ~/Documents/dotenv

# Run the installer (adds loader to .zshrc)
cd ~/Documents/dotenv
./install.sh

# Create symlinks
ln -sf ~/Documents/dotenv/vim/colors/kanagawa-gruvbox.vim ~/.vim/colors/
ln -sf ~/Documents/dotenv/gnome-extensions/focus-highlight@custom ~/.local/share/gnome-shell/extensions/

# Add to kitty.conf
echo "include ~/Documents/dotenv/kitty/theme.conf" >> ~/.config/kitty/kitty.conf

# Set vim colorscheme in .vimrc
echo "colorscheme kanagawa-gruvbox" >> ~/.vimrc

# Reload
source ~/.zshrc
```

## Zsh Functions

### Navigation

| Command | Description |
|---------|-------------|
| `back` | Go to previous directory in history |
| `back -a` | Select directory from history with fzf |

### Python / Venv

| Command | Description |
|---------|-------------|
| `venv [name]` | Create and activate a venv |
| `va [name]` | Activate existing venv |
| `venv-init` | Create venv + install requirements.txt |
| `venv-info` | Show active venv info |

### System

| Command | Description |
|---------|-------------|
| `maj` | System update (dnf) |
| `majall` | Full update (dnf + flatpak + firmware) |
| `cleanup` | Full system cleanup |
| `sysinfo` | Display system information |

### Podman

| Command | Description |
|---------|-------------|
| `pps` / `ppsa` | List containers |
| `psh` / `pbash` | Interactive shell into container (fzf) |
| `pstatus` | Full podman overview |
| `pcleanall` | Stop and remove all containers |

> Type `ws-help` or `podman-help` for full command reference.

## Requirements

- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) (optional)
- [fzf](https://github.com/junegunn/fzf)
- [Kitty](https://sw.kovidgoyal.net/kitty/) terminal
- GNOME Shell 45+

## License

MIT
