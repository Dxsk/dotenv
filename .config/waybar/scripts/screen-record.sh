#!/bin/bash
# Waybar status module for screen-record
PIDFILE="/tmp/screen-record.pid"
MODEFILE="/tmp/screen-record.mode"

if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    mode=$(cat "$MODEFILE" 2>/dev/null || echo "rec")
    echo "{\"text\": \"󰑋\", \"class\": \"recording\", \"tooltip\": \"Recording ($mode) - Clic droit pour arrêter\"}"
else
    echo "{\"text\": \"󰑊\", \"class\": \"idle\", \"tooltip\": \"Clic: menu record\"}"
fi
