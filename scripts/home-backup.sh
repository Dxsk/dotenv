#!/usr/bin/env bash
set -euo pipefail

NOTIFY_SEND="@notify_send@"
EXCLUDE_FILE="@exclude_file@"

notify_error() {
  "$NOTIFY_SEND" \
    --urgency=critical \
    --app-name="Backup" \
    --icon=dialog-error \
    "Backup failed" "$1"
  echo "ERROR: $1" >&2
}

notify_success() {
  "$NOTIFY_SEND" \
    --urgency=low \
    --app-name="Backup" \
    --icon=dialog-information \
    "Backup successful" "$1"
  echo "$1"
}

# bws (Bitwarden Secrets Manager CLI)
if ! command -v bws &>/dev/null; then
  notify_error "bws is not installed. Install with: yay -S bws-cli"
  exit 1
fi

# Access Token Bitwarden Secrets Manager
BWS_TOKEN_FILE="$HOME/.config/bws/$USER-desktop.key"
if [ ! -f "$BWS_TOKEN_FILE" ]; then
  notify_error "BWS Access Token not found: $BWS_TOKEN_FILE"
  exit 1
fi
BWS_ACCESS_TOKEN=$(<"$BWS_TOKEN_FILE")
export BWS_ACCESS_TOKEN

# Local config (BWS secret UUID, restic repo path)
BACKUP_CONFIG_FILE="$HOME/.config/home-backup/config"
if [ ! -f "$BACKUP_CONFIG_FILE" ]; then
  notify_error "Config not found: $BACKUP_CONFIG_FILE. Create it with BWS_SECRET_ID and RESTIC_REPO."
  exit 1
fi
# shellcheck source=/dev/null
source "$BACKUP_CONFIG_FILE"

if [ -z "${BWS_SECRET_ID:-}" ] || [ -z "${RESTIC_REPO:-}" ]; then
  notify_error "BWS_SECRET_ID and RESTIC_REPO must be defined in $BACKUP_CONFIG_FILE"
  exit 1
fi

# Restic retrieves the password via BWS on each call (never stored locally)
export RESTIC_PASSWORD_COMMAND="sh -c 'bws secret get $BWS_SECRET_ID --output json | jq -r .value'"

export RESTIC_REPOSITORY="$RESTIC_REPO"
export RCLONE_CONFIG="$HOME/.config/rclone/rclone.conf"
# Limit rclone bandwidth (0 = unlimited)
export RCLONE_BWLIMIT="${RCLONE_BWLIMIT:-10M}"

if [ ! -f "$RCLONE_CONFIG" ]; then
  notify_error "rclone config not found: $RCLONE_CONFIG"
  exit 1
fi

ACTION="${1:-backup}"

case "$ACTION" in
  init)
    echo "Initializing restic repository..."
    if restic init; then
      notify_success "Restic repository initialized successfully"
    else
      notify_error "Failed to initialize restic repository"
      exit 1
    fi
    ;;
  backup)
    echo "Backing up home directory..."
    if restic backup \
      --exclude-file="$EXCLUDE_FILE" \
      --exclude-caches \
      --one-file-system \
      --verbose \
      "$HOME"; then
      restic cache --cleanup
      notify_success "Home backup completed successfully"
    else
      notify_error "Failed to back up home to kDrive"
      exit 1
    fi
    ;;
  prune)
    echo "Cleaning up old snapshots..."
    if restic forget \
      --keep-daily 7 \
      --keep-weekly 4 \
      --keep-monthly 6 \
      --prune; then
      notify_success "Snapshot cleanup completed"
    else
      notify_error "Failed to clean up snapshots"
      exit 1
    fi
    ;;
  snapshots)
    restic snapshots
    ;;
  check)
    if restic check; then
      notify_success "Repository check: all good"
    else
      notify_error "Repository check: errors detected!"
      exit 1
    fi
    ;;
  restore)
    if [ -z "${2:-}" ]; then
      echo "Usage: home-backup restore <snapshot-id> [target-dir]"
      exit 1
    fi
    TARGET="${3:-$HOME/restore}"
    echo "Restoring snapshot $2 to $TARGET..."
    if restic restore "$2" --target "$TARGET"; then
      notify_success "Snapshot $2 restored to $TARGET"
    else
      notify_error "Failed to restore snapshot $2"
      exit 1
    fi
    ;;
  *)
    echo "Usage: home-backup {init|backup|prune|snapshots|check|restore <id> [target]}"
    exit 1
    ;;
esac
