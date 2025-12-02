#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────────
#                           DOTENV INSTALLER
# ─────────────────────────────────────────────────────────────────────────────────
# This script adds the dotenv loader to your .zshrc
# Usage: ./install.sh

DOTENV_DIR="$HOME/Documents/dotenv/zsh"
ZSHRC="$HOME/.zshrc"
MARKER="# DOTENV - Custom configurations"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Dotenv Installer${NC}"
echo "─────────────────────────────────"

# Check if already installed
if grep -q "$MARKER" "$ZSHRC" 2>/dev/null; then
    echo -e "${YELLOW}Dotenv loader already present in .zshrc${NC}"
    echo ""
    echo "Current zsh configs in $DOTENV_DIR:"
    find "$DOTENV_DIR" -maxdepth 1 -name "*.zsh" -exec basename {} \;
    exit 0
fi

# Backup .zshrc
cp "$ZSHRC" "$ZSHRC.backup.$(date +%Y%m%d%H%M%S)"
echo -e "Backup created: ${YELLOW}$ZSHRC.backup.*${NC}"

# Add loader to .zshrc
cat >> "$ZSHRC" << 'EOF'

# ─────────────────────────────────────────────────────────────────────────────────
# DOTENV - Custom configurations
# ─────────────────────────────────────────────────────────────────────────────────
# Loads all .zsh files from ~/Documents/dotenv/zsh/
DOTENV_DIR="$HOME/Documents/dotenv/zsh"
if [[ -d "$DOTENV_DIR" ]]; then
    for config in "$DOTENV_DIR"/*.zsh(N); do
        source "$config"
    done
fi
EOF

echo -e "${GREEN}✓ Dotenv loader added to .zshrc${NC}"
echo ""
echo "Configs that will be loaded:"
find "$DOTENV_DIR" -maxdepth 1 -name "*.zsh" -exec basename {} \;
echo ""
echo -e "Run ${YELLOW}source ~/.zshrc${NC} or restart your terminal to apply changes."
