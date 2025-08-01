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
    TARGET="$HOME"
  elif [ "$config" == "sddm" ]; then
    TARGET="/usr/share/sddm/themes"
  else
    TARGET="$HOME/.config"
  fi

  # Elimina el destino actual para evitar conflictos
  if [ "$config" == "sddm" ]; then
    # Para sddm se necesita sudo para eliminar
    sudo rm -rf "$TARGET/$config"
  else
    rm -rf "$TARGET/$config"
  fi

  # Aplica stow
  if [ "$config" == "sddm" ]; then
    sudo stow -d "$DOTFILES_DIR" -t "$TARGET" "$config"
  else
    stow -d "$DOTFILES_DIR" -t "$TARGET" "$config"
  fi
done

echo "✅ Dotfiles aplicados y sobreescritos."
