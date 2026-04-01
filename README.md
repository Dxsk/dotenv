# Dragon Fire Desktop

CachyOS (Arch) + Hyprland desktop configuration with Caelestia Shell and dynamic wallpaper theming.
Managed with **GNU Stow**.

---

## Theme

- **Source Color**: `#fd5622` (vivid orange)
- **Accent**: `#e53935` (red)
- **Style**: Kanagawa Dragon inspired, dynamic Material You palette via Caelestia
- **Wallpapers** change the entire color scheme automatically

## Stack

| Component      | Choice |
|---------------|--------|
| WM            | [Hyprland](https://hyprland.org/) (dwindle layout) |
| Shell         | [Caelestia Shell](https://github.com/caelestia-dots/shell) (Quickshell/QML) |
| Session       | [greetd](https://sr.ht/~kennylevinsen/greetd/) + [ReGreet](https://github.com/rharish101/ReGreet) |
| Terminal      | [Kitty](https://sw.kovidgoyal.net/kitty/) |
| Shell (CLI)   | [Zsh](https://www.zsh.org/) + [Oh My Zsh](https://ohmyz.sh/) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k) |
| Editor        | [Vim](https://www.vim.org/) + [VSCodium](https://vscodium.com/) |
| File Manager  | [Thunar](https://docs.xfce.org/xfce/thunar/start) |
| Browser       | [Zen Browser](https://zen-browser.app/) |
| Launcher      | [Caelestia launcher](https://github.com/caelestia-dots/shell) (integrated) |
| GTK Theme     | [adw-gtk3-dark](https://github.com/lassekongo83/adw-gtk3) + Caelestia dynamic colors |
| Qt Theme      | [Kvantum](https://github.com/tsujan/Kvantum) (WhiteSurDark) via qt6ct |
| Icons         | [Papirus-Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) |
| Cursor        | [Capitaine Cursors](https://github.com/keeferrourke/capitaine-cursors) |
| Font          | [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) |
| Screen Record | [gpu-screen-recorder](https://github.com/dec05eba/gpu-screen-recorder) (system + mic) |
| Images        | [Loupe](https://apps.gnome.org/Loupe/) |
| Archives      | [File Roller](https://wiki.gnome.org/Apps/FileRoller) |
| Backup        | [restic](https://restic.net/) + [rclone](https://rclone.org/) → kDrive |
| Git Identity  | [git-identity-manager](https://github.com/Dxsk/git-identity-manager) |

## Prerequisites

- [CachyOS](https://cachyos.org/) (or Arch Linux)
- [yay](https://github.com/Jguer/yay) (AUR helper)

## Install

```bash
git clone git@github.com:Dxsk/dotenv.git ~/Documents/github.com/Dxsk/dotenv
cd ~/Documents/github.com/Dxsk/dotenv
bash scripts/install.sh
```

The install script will:
1. Install `yay` and `stow` if missing
2. Install all packages (pacman + AUR)
3. Clean up old nix symlinks (if migrating)
4. Stow dotfiles to `~/`
5. Clone/update linked projects (git-identity-manager, mtd)
6. Enable systemd backup timers
7. Apply system tuning (sysctl, dbus limits)

After install, **log out and back in** for full effect.

## Update

```bash
dot   # alias: cd to dotenv + stow
```

## Structure

```
dotenv/
├── .config/
│   ├── hypr/
│   │   ├── hyprland.conf          # Main config (dwindle, i3-like binds)
│   │   ├── hyprlock.conf          # Lock screen
│   │   ├── hypridle.conf          # Idle timeouts
│   │   ├── hyprqt6engine.conf     # Qt6 engine config
│   │   ├── monitors.conf          # Monitor layout & refresh rates
│   │   └── workspaces.conf        # Workspace assignments per monitor
│   ├── caelestia/
│   │   ├── shell.json             # Shell config (bar, dashboard, theming, idle)
│   │   └── cli.json               # CLI config (record extraArgs for mic)
│   ├── kitty/
│   │   ├── kitty.conf
│   │   └── kanagawa-dragon.conf
│   ├── gtk-3.0/settings.ini       # GTK3 theme (adw-gtk3-dark)
│   ├── gtk-4.0/settings.ini       # GTK4 theme
│   ├── qt6ct/qt6ct.conf           # Qt6 theme (Kvantum)
│   ├── Kvantum/kvantum.kvconfig   # Kvantum theme (WhiteSurDark)
│   ├── zsh/                       # Zsh modules (sourced by .zshrc)
│   ├── systemd/user/              # Backup timers & services
│   ├── fastfetch/config.jsonc
│   ├── VSCodium/User/settings.json
│   ├── kdeglobals
│   └── vesktop-flags.conf         # Vesktop Wayland flags
├── .local/
│   ├── bin/
│   │   ├── home-backup            # Restic backup script
│   │   └── git-identity           # Git identity switcher
│   └── share/applications/
│       └── zen.desktop            # Zen Browser with --no-remote
├── .vim/
│   ├── colors/kanagawa-dragon.vim
│   └── config/                    # Modular vim config
├── .vimrc
├── .zshrc
├── system/
│   └── greetd/                    # Session manager configs (copied to /etc)
│       ├── config.toml
│       ├── hyprland.conf
│       └── regreet.toml
├── scripts/
│   ├── install.sh                 # Bootstrap script (packages, stow, system)
│   └── projects.conf              # Linked projects to clone/update
├── screenshots/
│   └── wallpaper.jpg              # Default wallpaper for greeter
└── .stow-local-ignore
```

## Keybindings

| Bind | Action |
|------|--------|
| `ALT + T` | Terminal (kitty) |
| `ALT + D` | App launcher (Caelestia) |
| `ALT + E` | File manager (thunar) |
| `ALT + C` | Kill window |
| `ALT + F` | Fullscreen |
| `ALT + V` | Toggle floating |
| `ALT + W` | Toggle tabbed group |
| `ALT + H` | Toggle split direction |
| `ALT + R` | Resize mode (arrows, Escape to exit) |
| `ALT + B` | Random wallpaper |
| `ALT + SHIFT + L` | Lock screen |
| `ALT + SHIFT + V` | Clipboard history |
| `ALT + SHIFT + S` | Screenshot region → clipboard |
| `ALT + SHIFT + M` | Exit Hyprland |
| `ALT + arrows` | Move focus |
| `ALT + SHIFT + arrows` | Move window |
| `ALT + 1-0` | Switch workspace |
| `ALT + SHIFT + 1-0` | Move window to workspace |
| `Print` | Screenshot region (with annotation) |
| `ALT + Print` | Screenshot fullscreen |

## Home Backup

Automated home directory backup using restic + rclone to kDrive (Infomaniak).

- `home-backup backup` — incremental backup
- `home-backup prune` — retention: 7 daily, 4 weekly, 6 monthly
- `home-backup restore <id>` — restore a snapshot
- Secrets via Bitwarden Secrets Manager (BWS) — never stored on disk
- Systemd timers: daily backup, weekly prune, monthly integrity check

## Linked Projects

The install script can automatically clone and set up external projects alongside the dotenv. This is configured in `scripts/projects.conf`:

```conf
# Format: git_repo_url  install_command (optional)
git@github.com:Dxsk/git-identity-manager.git  install -m755 git-identity.sh ~/.local/bin/git-identity
git@github.com:Dxsk/mtd.git  uv pip install -e .
```

Each line is a git repo to clone into the same parent directory as the dotenv. The optional install command runs from the project directory after clone/pull.

**Currently linked:**

| Project | Description | Install |
|---------|-------------|---------|
| [git-identity-manager](https://github.com/Dxsk/git-identity-manager) | Switch git identities per-repo with fzf | Copies script to `~/.local/bin` |
| [mtd](https://github.com/Dxsk/mtd) | Markdown to Documents converter | Python editable install via uv |

**To add your own project**, just append a line to `scripts/projects.conf`:

```conf
git@github.com:user/repo.git  optional_install_command
```

**To remove a project**, delete or comment out the line. Projects are only cloned/updated, never deleted — you manage that yourself.

On a fresh machine, `install.sh` clones everything. On subsequent runs, it pulls updates and re-runs install commands.
