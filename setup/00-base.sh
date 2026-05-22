#!/usr/bin/env bash
set -euo pipefail

echo "[Shadow Moses] Running base system setup..."

# -------------------------------------------------
# 1. Timezone setup
# -------------------------------------------------
# Sets system clock to your region.
# This affects logs, system time, and scheduling.
echo "[Base] Setting timezone..."
sudo ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
sudo hwclock --systohc

# -------------------------------------------------
# 2. Locale configuration
# -------------------------------------------------
# Defines language + encoding for the system.
# Needed so system text, logs, and apps behave correctly.
echo "[Base] Configuring locale..."

sudo sed -i 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen

echo "LANG=en_GB.UTF-8" | sudo tee /etc/locale.conf > /dev/null

# -------------------------------------------------
# 3. Hostname setup
# -------------------------------------------------
# This is the machine name shown on networks and terminal.
echo "[Base] Setting hostname..."

HOSTNAME="shadowmoses"

echo "$HOSTNAME" | sudo tee /etc/hostname > /dev/null

sudo bash -c "cat > /etc/hosts <<EOF
127.0.0.1   localhost
::1         localhost
127.0.1.1   $HOSTNAME.localdomain $HOSTNAME
EOF"

# -------------------------------------------------
# 4. Enable multilib (important for pentesting tools)
# -------------------------------------------------
# Allows 32-bit libraries on 64-bit systems.
# Required for tools like Steam dependencies, Wine, etc.
echo "[Base] Enabling multilib repository..."

sudo sed -i '/^\[multilib\]/,/^Include/ s/^#//' /etc/pacman.conf

# -------------------------------------------------
# 5. Update package database after config changes
# -------------------------------------------------
echo "[Base] Refreshing package database..."
sudo pacman -Sy

# -------------------------------------------------
# Done
# -------------------------------------------------
echo "[Shadow Moses] Base system setup complete."
