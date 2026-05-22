#!/usr/bin/env bash
set -euo pipefail

echo "[Shell] Configuring shell profiles for Shadow Moses users..."

users=(mgs rex ray)

# -----------------------------
# Hyprland autostart block
# -----------------------------
HYPR_BLOCK='
# Shadow Moses - auto start Hyprland on tty1
if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec Hyprland
fi
'

for user in "${users[@]}"; do

    HOME_DIR="/home/$user"
    BASH_PROFILE="$HOME_DIR/.bash_profile"
    BASHRC="$HOME_DIR/.bashrc"

    echo "[Shell] Configuring $user"

    # -----------------------------
    # Ensure bashrc exists
    # -----------------------------
    if [ ! -f "$BASHRC" ]; then
        touch "$BASHRC"
        chown "$user:$user" "$BASHRC"
    fi

    # -----------------------------
    # Only apply Hyprland autostart to mgs
    # -----------------------------
    if [ "$user" = "mgs" ]; then

        if ! grep -q "exec Hyprland" "$BASH_PROFILE" 2>/dev/null; then
            echo "$HYPR_BLOCK" >> "$BASH_PROFILE"
        fi

        chown "$user:$user" "$BASH_PROFILE"

    else
        # ensure no GUI autostart for rex/ray
        if [ -f "$BASH_PROFILE" ]; then
            sed -i '/exec Hyprland/d' "$BASH_PROFILE"
        fi
    fi

done

echo "[Shell] Shell configuration complete."
