#!/usr/bin/env bash
set -euo pipefail

echo "[Users] Creating Shadow Moses user environment..."

users=(mgs rex ray)

# -----------------------------
# 1. Ask for password once
# -----------------------------
read -rsp "[Users] Enter password for all Shadow Moses users: " PASSWORD
echo

# -----------------------------
# 2. Create users
# -----------------------------
for user in "${users[@]}"; do
    if ! id "$user" &>/dev/null; then
        echo "[Users] Creating user: $user"

        useradd -m -s /bin/bash "$user"
        echo "$user:$PASSWORD" | chpasswd
    else
        echo "[Users] User already exists: $user"
    fi
done

# -----------------------------
# 3. Ensure sudo exists
# -----------------------------
pacman -S --needed --noconfirm sudo

# -----------------------------
# 4. Enable wheel sudo access
# -----------------------------
if ! grep -q "^%wheel" /etc/sudoers; then
    echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
fi

echo "[Users] Shadow Moses users created."
