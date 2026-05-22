#!/usr/bin/env bash
set -euo pipefail

echo "[Packages] Installing Hyprland desktop stack..."

# -----------------------------
# Core system utilities
# -----------------------------
core_packages=(
    git
    curl
    wget
    vim
    networkmanager
    pipewire
    pipewire-pulse
    wireplumber
    xdg-utils
    xdg-user-dirs
)

# -----------------------------
# Fonts (important for UI)
# -----------------------------
font_packages=(
    noto-fonts
    noto-fonts-emoji
    ttf-dejavu
)

# -----------------------------
# Hyprland + Wayland stack
# -----------------------------
hyprland_packages=(
    hyprland
    xdg-desktop-portal-hyprland
    waybar
    wofi
    kitty
    thunar
    thunar-archive-plugin
)

# -----------------------------
# Utilities (desktop quality-of-life)
# -----------------------------
util_packages=(
    wl-clipboard
    grim
    slurp
    swappy
    mako
    polkit-kde-agent
)

install() {
    echo "[Packages] Installing: $*"
    pacman -S --needed --noconfirm "$@"
}

install "${core_packages[@]}"
install "${font_packages[@]}"
install "${hyprland_packages[@]}"
install "${util_packages[@]}"

echo "[Packages] Hyprland stack installed."
