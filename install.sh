#!/bin/bash

CONFIG_DIR="$HOME/kofe-dotfiles/configs"
BACKUP_DIR="$HOME/kofe-dotfiles/backups"

echo "Instalando dotfiles desde $CONFIG_DIR..."
mkdir -p "$BACKUP_DIR"

# Función para respaldar y crear symlink como usuario normal
backup_and_link() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Moviendo $dest a $BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
    fi

    echo "Creando symlink: $dest -> $src"
    ln -sf "$src" "$dest"
}

# Hyprland configs
mkdir -p "$HOME/.config/hypr"
for file in "$CONFIG_DIR/hypr/"*; do
    [ -e "$file" ] || continue
    backup_and_link "$file" "$HOME/.config/hypr/$(basename $file)"
done

# Waybar configs
mkdir -p "$HOME/.config/waybar"
for file in "$CONFIG_DIR/waybar/"*; do
    [ -e "$file" ] || continue
    backup_and_link "$file" "$HOME/.config/waybar/$(basename $file)"
done

# Nwg-displays configs
mkdir -p "$HOME/.config/nwg-displays"
for file in "$CONFIG_DIR/nwg-displays/"*; do
    [ -e "$file" ] || continue
    backup_and_link "$file" "$HOME/.config/nwg-displays/$(basename $file)"
done

# SDDM configs (system-wide, requiere sudo)
# Themes
for file in "$CONFIG_DIR/sddm/themes/"*; do
    if [ -e "/usr/share/sddm/themes/$(basename $file)" ]; then
        echo "Respaldando /usr/share/sddm/themes/$(basename $file)"
        sudo mv "/usr/share/sddm/themes/$(basename $file)" "$BACKUP_DIR/"
    fi
    echo "Creando symlink SDDM theme con sudo: $(basename $file)"
    sudo ln -sf "$file" "/usr/share/sddm/themes/$(basename $file)"
done

# Archivo sddm.conf
if [ -e "/etc/sddm.conf" ]; then
    echo "Respaldando /etc/sddm.conf"
    sudo mv "/etc/sddm.conf" "$BACKUP_DIR/"
fi
echo "Creando symlink sddm.conf con sudo"
sudo ln -sf "$CONFIG_DIR/sddm/sddm.conf" "/etc/sddm.conf"

echo "Dotfiles instalados. Los archivos antiguos están en $BACKUP_DIR."
