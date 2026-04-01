#!/usr/bin/env bash
set -euo pipefail

DOTENV_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PROJECTS_DIR="$(dirname "$DOTENV_DIR")"
PROJECTS_CONF="$DOTENV_DIR/scripts/projects.conf"

echo "=== Dotenv install ==="
echo "Repo: $DOTENV_DIR"
echo ""

# ──────────────────────────────────────
# 1. Bootstrap: yay + stow
# ──────────────────────────────────────
if ! command -v yay &>/dev/null; then
  echo "Installing yay..."
  sudo pacman -S --needed --noconfirm git base-devel
  tmpdir=$(mktemp -d)
  git clone https://aur.archlinux.org/yay-bin.git "$tmpdir/yay-bin"
  (cd "$tmpdir/yay-bin" && makepkg -si --noconfirm)
  rm -rf "$tmpdir"
fi

if ! command -v stow &>/dev/null; then
  echo "Installing stow..."
  sudo pacman -S --noconfirm stow
fi

# ──────────────────────────────────────
# 2. Install packages
# ──────────────────────────────────────
echo ""
echo "=== Packages ==="

# Core desktop
PACMAN_PKGS=(
  hyprland hyprlock hypridle
  xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
  kitty thunar
  kvantum qt6ct-kde nwg-look
  grimblast-git
  playerctl brightnessctl
)

# Session manager
PACMAN_PKGS+=(
  greetd greetd-regreet
)

# Theming
PACMAN_PKGS+=(
  adw-gtk-theme
  papirus-icon-theme
  ttf-material-symbols-variable
  ttf-rubik-vf
  ttf-cascadia-code-nerd
  capitaine-cursors
)

# GTK4 apps
PACMAN_PKGS+=(
  loupe
  file-roller
)

# Audio/media
PACMAN_PKGS+=(
  gpu-screen-recorder
  pipewire wireplumber
  mpv vlc
)

# Shell & tools
PACMAN_PKGS+=(
  bat eza fd dust btop zoxide thefuck fzf jq
  restic rclone
  stow wl-clipboard
)

# Caelestia shell (AUR)
AUR_PKGS=(
  caelestia-shell-git
  hyprlauncher
  zen-browser-bin
)

echo "Checking pacman packages..."
missing_pacman=()
for pkg in "${PACMAN_PKGS[@]}"; do
  pacman -Qi "$pkg" &>/dev/null 2>&1 || missing_pacman+=("$pkg")
done

echo "Checking AUR packages..."
missing_aur=()
for pkg in "${AUR_PKGS[@]}"; do
  pacman -Qi "$pkg" &>/dev/null 2>&1 || missing_aur+=("$pkg")
done

if [ ${#missing_pacman[@]} -gt 0 ]; then
  echo "Installing: ${missing_pacman[*]}"
  sudo pacman -S --needed --noconfirm "${missing_pacman[@]}" || true
fi

if [ ${#missing_aur[@]} -gt 0 ]; then
  echo "Installing (AUR): ${missing_aur[*]}"
  yay -S --needed --noconfirm "${missing_aur[@]}" || true
fi

echo "Packages OK."

# ──────────────────────────────────────
# 3. Clean up stale symlinks
# ──────────────────────────────────────
echo ""
echo "Cleaning up old/stale symlinks..."
for f in \
  ~/.config/hypr/hyprland.conf \
  ~/.config/hypr/monitors.conf \
  ~/.config/hypr/workspaces.conf \
  ~/.config/hypr/hypridle.conf \
  ~/.config/hypr/hyprqt6engine.conf \
  ~/.config/gtk-3.0/settings.ini \
  ~/.config/gtk-4.0/settings.ini \
  ~/.config/Kvantum/kvantum.kvconfig \
  ~/.config/qt6ct/qt6ct.conf \
  ~/.config/fastfetch/config.jsonc \
  ~/.config/kdeglobals \
  ~/.config/vesktop-flags.conf \
  ~/.config/kitty/kitty.conf \
  ~/.zshrc \
  ~/.vimrc \
; do
  if [ -L "$f" ]; then
    target="$(readlink "$f")"
    if [[ "$target" == /nix/store/* ]] || [[ "$target" == *home-manager-files* ]]; then
      echo "  rm $f (nix symlink)"
      rm "$f"
    fi
  fi
done

# ──────────────────────────────────────
# 4. Stow dotfiles
# ──────────────────────────────────────
echo ""
echo "Stowing dotfiles..."
cd "$DOTENV_DIR"
stow -t "$HOME" --verbose=1 .

# ──────────────────────────────────────
# 5. Clone/update linked projects
# ──────────────────────────────────────
if [ -f "$PROJECTS_CONF" ]; then
  echo ""
  echo "=== Projects ==="
  while IFS= read -r line; do
    [[ "$line" =~ ^[[:space:]]*# ]] && continue
    [[ -z "${line// }" ]] && continue

    repo_url=$(echo "$line" | awk '{print $1}')
    install_cmd=$(echo "$line" | cut -d' ' -f2- -s)
    project_name=$(basename "$repo_url" .git)
    project_dir="$PROJECTS_DIR/$project_name"

    if [ -d "$project_dir" ]; then
      echo "  Updating $project_name..."
      git -C "$project_dir" pull --ff-only 2>/dev/null || echo "    (pull skipped)"
    else
      echo "  Cloning $project_name..."
      git clone "$repo_url" "$project_dir"
    fi

    if [ -n "$install_cmd" ]; then
      echo "  Installing $project_name..."
      (cd "$project_dir" && eval "$install_cmd")
    fi
  done < "$PROJECTS_CONF"
fi

# ──────────────────────────────────────
# 6. Enable systemd user services
# ──────────────────────────────────────
echo ""
echo "Enabling services..."
systemctl --user daemon-reload
systemctl --user enable --now home-backup.timer 2>/dev/null || true
systemctl --user enable --now home-backup-prune.timer 2>/dev/null || true
systemctl --user enable --now home-backup-check.timer 2>/dev/null || true

# ──────────────────────────────────────
# 7. System tuning (needs sudo)
# ──────────────────────────────────────
if [ ! -f /etc/sysctl.d/99-longrun.conf ]; then
  echo ""
  echo "Applying system tuning..."
  sudo tee /etc/sysctl.d/99-longrun.conf > /dev/null <<'SYSCTL'
vm.swappiness = 100
vm.vfs_cache_pressure = 50
SYSCTL
  sudo sysctl --system > /dev/null
fi

if [ ! -f /etc/dbus-1/session-local.conf ]; then
  echo "Applying dbus limits..."
  sudo mkdir -p /etc/dbus-1
  sudo tee /etc/dbus-1/session-local.conf > /dev/null <<'DBUS'
<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-Bus Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>
  <limit name="max_incoming_bytes">536870912</limit>
  <limit name="max_outgoing_bytes">536870912</limit>
  <limit name="max_message_size">134217728</limit>
  <limit name="max_completed_connections">8192</limit>
  <limit name="max_pending_service_starts">1024</limit>
</busconfig>
DBUS
fi

# ──────────────────────────────────────
# 8. Session manager (greetd + regreet)
# ──────────────────────────────────────
echo ""
echo "Setting up greetd..."
sudo mkdir -p /etc/greetd
sudo cp "$DOTENV_DIR/system/greetd/config.toml" /etc/greetd/config.toml
sudo cp "$DOTENV_DIR/system/greetd/hyprland.conf" /etc/greetd/hyprland.conf
sed "s|__HOME__|$HOME|g; s|__DOTENV__|$DOTENV_DIR|g" "$DOTENV_DIR/system/greetd/regreet.toml" | sudo tee /etc/greetd/regreet.toml > /dev/null
sudo systemctl disable lightdm 2>/dev/null || true
sudo systemctl enable greetd 2>/dev/null || true

# ──────────────────────────────────────
# Done
# ──────────────────────────────────────
echo ""
echo "=== Done ==="
echo "Log out and back in for full effect."
echo ""
echo "Post-install:"
echo "  - Run 'nwg-look' to verify GTK theme"
echo "  - Run 'qt6ct' to verify Qt theme"
echo "  - Caelestia config: ~/.config/caelestia/shell.json"
