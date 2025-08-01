#!/bin/bash

DOTFILES_DIR="$HOME/kofe-dotfiles"

CONFIGS=(
  backgrounds
  hyprland
  fastfetch
  waybar
  hyprpaper
  kitty
  starship
  bash
  sddm
)

for config in "${CONFIGS[@]}"; do
  echo "Aplicando stow para $config..."

  if [ "$config" == "bash" ]; then
    stow -d "$DOTFILES_DIR" -t "$HOME" bash
  elif [ "$config" == "sddm" ]; then
    sudo stow -d "$DOTFILES_DIR" -t /usr/share/sddm/themes sddm
  else
    stow -d "$DOTFILES_DIR" -t "$HOME/.config" "$config"
  fi
done

echo "✅ Dotfiles aplicados."
