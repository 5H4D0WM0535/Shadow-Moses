#!/usr/bin/env bash

# -------------------------------------------------
# Strict mode (important for installers)
# -------------------------------------------------
# -e  : exit immediately if any command fails
# -u  : treat unset variables as errors (prevents silent bugs)
# -o pipefail : if any command in a pipeline fails, the whole pipeline fails
#
# Why this matters:
# This ensures the installer does NOT continue in a broken or partial state.
# It makes failures loud and immediate instead of hidden.
set -euo pipefail


echo "[Shadow Moses] Starting installation..."

# -----------------------------
# 1. Check OS
# -----------------------------
if [[ ! -f /etc/arch-release ]]; then
  echo "Error: This installer is only for Arch Linux."
  exit 1
fi

# -----------------------------
# 2. Update system
# -----------------------------
echo "[1/4] Updating system..."
sudo pacman -Syu --noconfirm

# -----------------------------
# 3. Install base dependencies
# -----------------------------
echo "[2/4] Installing base packages..."
sudo pacman -S --needed --noconfirm \
  git \
  base-devel \
  curl \
  wget

# -----------------------------
# 4. Run setup scripts
# -----------------------------
echo "[3/4] Running setup scripts..."

# -------------------------------------------------
# Resolve script directory (very important)
# -------------------------------------------------
# BASH_SOURCE[0] → path to this script file
# dirname → extracts the folder containing the script
# cd + pwd → converts it into an absolute path
#
# Why this matters:
# Ensures the script works no matter where it is executed from.
# Without this, relative paths like ./setup/... could break.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

bash "$SCRIPT_DIR/setup/00-base.sh"
bash "$SCRIPT_DIR/setup/01-users.sh"
bash "$SCRIPT_DIR/setup/02-packages.sh"
bash "$SCRIPT_DIR/setup/03-dotfiles.sh"

# -----------------------------
# Done
# -----------------------------
echo "[Shadow Moses] Base installation complete."
echo "Next step: reboot or continue with Hyprland setup."
