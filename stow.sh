#!/bin/bash

packages=(
    "backgrounds"
    "hyprland"
    "fastfetch"
    "waybar"
    "hyprpaper"
    "kitty"
    "starship"
    "bash"
    "sddm"
)

DOTFILES_DIR="$(pwd)"

cd "$DOTFILES_DIR" || { echo "No se pudo acceder a $DOTFILES_DIR"; exit 1; }

for package in "${packages[@]}"; do
    if [ -d "$package" ]; then
        if [ "$package" == "sddm" ]; then
            echo "Copiando tema SDDM a /usr/share/sddm/themes con sudo..."
            sudo cp -r "$DOTFILES_DIR/sddm/." /usr/share/sddm/themes/
        else
            echo "Aplicando stow -R a $package..."
            stow -R "$package"
        fi
    else
        echo "El directorio $package no existe, se omite."
    fi
done

echo "Proceso completado."
