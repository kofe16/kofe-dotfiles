#!/bin/bash

# Lista de paquetes a aplicar stow
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

# Aplicar stow a cada paquete
for package in "${packages[@]}"; do
    if [ -d "$package" ]; then
        echo "Aplicando stow a $package..."
        stow "$package"
    else
        echo "El directorio $package no existe."
    fi
done

# Manejar sddm por separado

sddm_dir="sddm"

if [ -d "$sddm_dir" ]; then

    echo "Moviendo $sddm_dir a /usr/share/sddm/themes..."

    sudo cp -r "$sddm_dir"/* /usr/share/sddm/themes/

    sudo chown -R root:root /usr/share/sddm/themes/*

    sudo chmod -R 755 /usr/share/sddm/themes/*

else

    echo "El directorio $sddm_dir no existe."

fi

echo "Proceso completado."