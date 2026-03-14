#!/bin/bash
# Setup script for captive portal login automation
# Run this once after cloning dotfiles

DOTFILES_SCRIPTS="$HOME/dotfiles-black-minimal/hypr/.config/hypr/scripts"
TARGET="$HOME/.config/hypr/scripts"

echo "→ Symlinking scripts/ into ~/.config/hypr/ ..."
ln -sfn "$DOTFILES_SCRIPTS" "$TARGET"
echo "  Linked: $DOTFILES_SCRIPTS → $TARGET"

echo "→ Making scripts executable ..."
chmod +x "$DOTFILES_SCRIPTS/login.sh"
chmod +x "$DOTFILES_SCRIPTS/watch-network.sh"

# Copy .env if it doesn't exist yet
if [ ! -f "$TARGET/.env" ]; then
    if [ -f "$DOTFILES_SCRIPTS/.env" ]; then
        echo "→ .env already in dotfiles scripts dir (will be accessible via symlink)"
    else
        cp "$DOTFILES_SCRIPTS/.env.example" "$TARGET/.env"
        echo "→ Copied .env.example → .env. Please fill in your credentials."
    fi
else
    echo "→ .env already exists at $TARGET/.env, skipping."
fi

echo ""
echo "✓ Done! Starting the network watcher..."
pkill -f watch-network.sh 2>/dev/null
nohup "$TARGET/watch-network.sh" > /tmp/watch-network.log 2>&1 &
echo "  Watcher PID: $!"
echo "  Logs: /tmp/watch-network.log"
