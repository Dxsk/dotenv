# Dragon Fire Desktop

CachyOS (Arch) + Hyprland desktop configuration with Waybar and dynamic wallpaper theming via matugen.
Managed with **GNU Stow**.

---

## Theme

- **Source Color**: `#fd5622` (vivid orange)
- **Accent**: `#e53935` (red)
- **Style**: Kanagawa Dragon inspired, dynamic Material You palette via [matugen](https://github.com/InioX/matugen)
- **Wallpapers** change the entire color scheme automatically (waybar, rofi, swaync, swayosd, hyprland)

## Stack

| Component      | Choice |
|---------------|--------|
| WM            | [Hyprland](https://hyprland.org/) (dwindle layout) |
| Bar           | [Waybar](https://github.com/Alexays/Waybar) |
| Notifications | [SwayNC](https://github.com/ErikReider/SwayNotificationCenter) |
| OSD           | [SwayOSD](https://github.com/ErikReider/SwayOSD) |
| Session       | [greetd](https://sr.ht/~kennylevinsen/greetd/) + [ReGreet](https://github.com/rharish101/ReGreet) |
| Terminal      | [Kitty](https://sw.kovidgoyal.net/kitty/) |
| Shell (CLI)   | [Zsh](https://www.zsh.org/) + [Oh My Zsh](https://ohmyz.sh/) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k) |
| Editor        | [Vim](https://www.vim.org/) + [VSCodium](https://vscodium.com/) |
| File Manager  | [Thunar](https://docs.xfce.org/xfce/thunar/start) |
| Browser       | [Zen Browser](https://zen-browser.app/) |
| Launcher      | [Rofi](https://github.com/davatorium/rofi) (Wayland fork) |
| GTK Theme     | [adw-gtk3-dark](https://github.com/lassekongo83/adw-gtk3) + matugen dynamic colors |
| Qt Theme      | [Kvantum](https://github.com/tsujan/Kvantum) (WhiteSurDark) via qt6ct |
| Icons         | [Papirus-Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) |
| Cursor        | [Capitaine Cursors](https://github.com/keeferrourke/capitaine-cursors) |
| Font          | [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) |
| Screen Record | [gpu-screen-recorder](https://github.com/dec05eba/gpu-screen-recorder) (system + mic) |
| Images        | [Loupe](https://apps.gnome.org/Loupe/) |
| Archives      | [File Roller](https://wiki.gnome.org/Apps/FileRoller) |
| Monitoring    | [btop](https://github.com/aristocratos/btop) |
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

### Quick commands (Makefile)

```bash
make install    # stow dotfiles to ~/
make uninstall  # remove symlinks
make reinstall  # restow (after adding/removing files)
make check      # dry-run
```

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
│   ├── waybar/
│   │   ├── config.jsonc           # Top bar config
│   │   ├── sidebar.jsonc          # Side bar config
│   │   ├── style.css              # Waybar styling
│   │   └── scripts/               # Waybar helper scripts
│   ├── matugen/
│   │   ├── config.toml            # Dynamic theming config
│   │   └── templates/             # Color templates (waybar, rofi, swaync, swayosd, hypr)
│   ├── rofi/                      # App launcher config & theme
│   ├── swaync/                    # Notification center config
│   ├── swayosd/                   # OSD overlay config
│   ├── caelestia/                 # Caelestia CLI/shell config (legacy theming)
│   ├── kitty/
│   │   ├── kitty.conf
│   │   └── kanagawa-dragon.conf
│   ├── btop/btop.conf             # System monitor config
│   ├── gtk-3.0/
│   │   ├── settings.ini           # GTK3 theme (adw-gtk3-dark)
│   │   ├── gtk.css                # Custom GTK3 colors
│   │   └── thunar.css             # Thunar custom theme
│   ├── gtk-4.0/
│   │   ├── settings.ini           # GTK4 theme
│   │   ├── gtk.css                # Custom GTK4 colors
│   │   └── thunar.css             # Thunar custom theme
│   ├── qt6ct/
│   │   ├── qt6ct.conf             # Qt6 theme (Kvantum)
│   │   └── colors/ambxst.colors   # Custom Qt color scheme
│   ├── Kvantum/kvantum.kvconfig   # Kvantum theme (WhiteSurDark)
│   ├── zsh/                       # Zsh modules (sourced by .zshrc)
│   ├── systemd/user/              # Backup timers, services & portal overrides
│   ├── fastfetch/config.jsonc
│   ├── VSCodium/User/settings.json
│   ├── kdeglobals
│   └── vesktop-flags.conf         # Vesktop Wayland flags
├── .local/
│   ├── bin/
│   │   ├── home-backup            # Restic backup script
│   │   ├── git-identity           # Git identity switcher
│   │   ├── change-wallpaper       # Random wallpaper + matugen recolor
│   │   ├── reload-theme           # Reload all theme components
│   │   ├── screen-record          # Screen recording helper
│   │   ├── screenshot-menu        # Screenshot menu
│   │   ├── toggle-notifications   # Toggle swaync
│   │   ├── toggle-showkeys        # Toggle key display overlay
│   │   ├── toggle-topbar          # Toggle waybar visibility
│   │   ├── knob-daemon            # Hardware knob input daemon
│   │   ├── timer                  # Timer utility
│   │   └── weather-fullscreen     # Weather display
│   └── share/applications/
│       └── zen.desktop            # Zen Browser with --no-remote
├── .vim/
│   ├── colors/kanagawa-dragon.vim
│   └── config/                    # Modular vim config
├── .vimrc
├── .zshrc
├── Makefile                       # Quick stow commands
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
| `ALT + D` | App launcher (rofi) |
| `ALT + E` | File manager (thunar) |
| `ALT + C` | Kill window |
| `ALT + F` | Fullscreen |
| `ALT + V` | Toggle floating |
| `ALT + W` | Toggle tabbed group |
| `ALT + H` | Toggle split direction |
| `ALT + L` | Lock screen |
| `ALT + R` | Resize mode (arrows, Escape to exit) |
| `ALT + B` | Random wallpaper + recolor |
| `ALT + N` | Toggle notifications |
| `ALT + A` | Toggle top bar |
| `ALT + SHIFT + L` | Lock session |
| `ALT + SHIFT + V` | Clipboard history (rofi) |
| `ALT + SHIFT + S` | Screenshot region → clipboard |
| `ALT + SHIFT + K` | Toggle key display overlay |
| `ALT + SHIFT + M` | Exit Hyprland |
| `ALT + arrows` | Move focus |
| `ALT + SHIFT + arrows` | Move window |
| `ALT + TAB / SHIFT+TAB` | Cycle group tabs |
| `ALT + 1-0` | Switch workspace |
| `ALT + SHIFT + 1-0` | Move window to workspace |
| `Print` | Screenshot region → clipboard |
| `SHIFT + Print` | Screenshot current output |
| `ALT + Print` | Screenshot current window |

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
