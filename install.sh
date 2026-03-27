#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/shyamjames/dotfiles-black-minimal.git"
REPO_DIR="${HOME}/dotfiles-black-minimal"
YAY_DIR="/tmp/yay-$$"

DEPENDENCIES=(
  hyprland
  ghostty
  kitty
  waybar
  zsh
  rofi
  wlogout
  dunst
  swaybg
  hypridle
  hyprlock
  thunar
  ttf-cascadia-code-nerd
  brightnessctl
  playerctl
  hyprshot
  cliphist
  sddm
  imagemagick
  blueman
  bluez
  bluez-utils
  pipewire
  wireplumber
  pipewire-pulse
  pavucontrol
  networkmanager
  wireless_tools
  libnotify
  curl
  stow
)

STOW_PACKAGES=(
  hypr
  ghostty
  kitty
  waybar
  rofi
  wlogout
  dunst
  zsh
  alacritty
  nvim
)

ensure_git() {
  if command -v git >/dev/null 2>&1; then
    return
  fi

  echo "git not found. Installing git with pacman..."
  sudo pacman -S --needed --noconfirm git
}

ensure_repo() {
  if [[ -d "${REPO_DIR}/.git" ]]; then
    echo "Using existing repository at ${REPO_DIR}"
    return
  fi

  echo "Cloning dotfiles repo into ${REPO_DIR}"
  git clone "${REPO_URL}" "${REPO_DIR}"
}

ensure_yay() {
  if command -v yay >/dev/null 2>&1; then
    echo "yay is already installed."
    return
  fi

  echo "yay not found. Installing required build tools..."
  sudo pacman -S --needed --noconfirm base-devel git

  echo "Cloning yay to ${YAY_DIR}"
  rm -rf "${YAY_DIR}"
  git clone https://aur.archlinux.org/yay.git "${YAY_DIR}"

  echo "Building and installing yay..."
  (
    cd "${YAY_DIR}"
    makepkg -si --noconfirm
  )

  rm -rf "${YAY_DIR}"
}

install_dependencies() {
  echo "Installing dependencies with yay..."
  yay -S --needed --noconfirm "${DEPENDENCIES[@]}"
}

print_stow_menu() {
  echo
  echo "Available stow packages:"
  for i in "${!STOW_PACKAGES[@]}"; do
    printf "%2d) %s\n" "$((i + 1))" "${STOW_PACKAGES[i]}"
  done
  echo
}

stow_selected_packages() {
  local selected raw token idx package

  print_stow_menu
  read -r -p "Enter package numbers to stow (space-separated): " raw

  if [[ -z "${raw}" ]]; then
    echo "No package numbers provided. Skipping stow."
    return
  fi

  selected=()
  for token in ${raw}; do
    if [[ ! "${token}" =~ ^[0-9]+$ ]]; then
      echo "Ignoring invalid input: ${token}"
      continue
    fi

    idx=$((token - 1))
    if (( idx < 0 || idx >= ${#STOW_PACKAGES[@]} )); then
      echo "Ignoring out-of-range package number: ${token}"
      continue
    fi

    package="${STOW_PACKAGES[idx]}"
    if [[ -d "${REPO_DIR}/${package}" ]]; then
      selected+=("${package}")
    else
      echo "Skipping missing package directory: ${package}"
    fi
  done

  if (( ${#selected[@]} == 0 )); then
    echo "No valid stow packages selected."
    return
  fi

  echo "Stowing: ${selected[*]}"
  (
    cd "${REPO_DIR}"
    stow "${selected[@]}"
  )

  echo "Stow complete."
}

main() {
  ensure_git
  ensure_repo
  ensure_yay
  install_dependencies

  echo
  read -r -p "Do you want to stow packages now? [y/N]: " answer
  if [[ "${answer}" =~ ^[Yy]$ ]]; then
    stow_selected_packages
  else
    echo "Skipping stow."
  fi

  echo "Done."
}

main "$@"
