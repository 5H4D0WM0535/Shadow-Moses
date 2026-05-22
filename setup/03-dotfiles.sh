#!/usr/bin/env bash
set -euo pipefail

echo "[Dotfiles] Setting up basic Hyprland configuration..."

USER_HOME="/home/$SUDO_USER"

if [ -z "$SUDO_USER" ]; then
    echo "[Dotfiles] Error: Run this script with sudo from your user."
    exit 1
fi

DOTDIR="$USER_HOME/.config"

mkdir -p "$DOTDIR"

# -----------------------------
# 1. Hyprland config
# -----------------------------
mkdir -p "$DOTDIR/hypr"

cat > "$DOTDIR/hypr/hyprland.conf" << 'EOF'
# Shadow Moses - Minimal Hyprland config

monitor=,preferred,auto,1

input {
    kb_layout = gb
}

general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
}

bind = SUPER, RETURN, exec, kitty
bind = SUPER, D, exec, wofi --show drun
bind = SUPER, Q, killactive
bind = SUPER, M, exit
EOF

# -----------------------------
# 2. Waybar config
# -----------------------------
mkdir -p "$DOTDIR/waybar"

cat > "$DOTDIR/waybar/config" << 'EOF'
{
    "layer": "top",
    "position": "top",
    "modules-left": ["clock"],
    "modules-right": ["network", "pulseaudio"]
}
EOF

cat > "$DOTDIR/waybar/style.css" << 'EOF'
* {
    font-family: monospace;
    font-size: 12px;
}
EOF

# -----------------------------
# 3. Kitty config
# -----------------------------
mkdir -p "$DOTDIR/kitty"

cat > "$DOTDIR/kitty/kitty.conf" << 'EOF'
font_size 12
background_opacity 0.9
EOF

# -----------------------------
# 4. Wofi config
# -----------------------------
mkdir -p "$DOTDIR/wofi"

cat > "$DOTDIR/wofi/config" << 'EOF'
show=drun
prompt=Shadow Moses
EOF

echo "[Dotfiles] Basic configs installed."
