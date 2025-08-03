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

# Aplicar stow con --adopt para cada paquete
for package in "${packages[@]}"; do
    if [ -d "$package" ]; then
        if [ "$package" == "sddm" ]; then
    echo "Copiando temas SDDM a /usr/share/sddm/themes con sudo..."
    sudo cp -r "$DOTFILES_DIR/sddm/themes/." /usr/share/sddm/themes/

    echo "Copiando sddm.conf a /etc con sudo..."
    sudo cp "$DOTFILES_DIR/sddm/sddm.conf" /etc/sddm.conf
else
    echo "Aplicando stow --adopt a $package..."
    stow --adopt "$package"
fi

    else
        echo "El directorio $package no existe, se omite."
    fi
done

echo "Proceso completado."
