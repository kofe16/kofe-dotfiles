1#!/bin/bash
set -e

########################
# RUTAS
########################
CONFIG_DIR="$HOME/kofe-dotfiles/configs"
BACKUP_DIR="$HOME/kofe-dotfiles/backups"

echo "🚀 Instalando Kofe-Rice..."
mkdir -p "$BACKUP_DIR"

########################
# CHECK ARCH
########################
if ! command -v pacman &>/dev/null; then
    echo "❌ Este script es solo para Arch Linux"
    exit 1
fi

########################
# PAQUETES
########################
PACKAGES=(
    hyprland
    hyprpaper
    waybar
    nwg-displays
    brightnessctl
    bluetui
    ttf-jetbrains-mono-nerd
    qt5-graphicaleffects
    qt5-quickcontrols
    qt5-quickcontrols2
    fastfetch
    flatpak
)

echo "📦 Instalando paquetes..."
sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

########################
# FUNCIÓN BACKUP
########################
backup_file() {
    local dest="$1"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "📦 Respaldando $dest"
        mv "$dest" "$BACKUP_DIR/$(basename "$dest")_backup_$(date +%s)"
    fi
}

########################
# SYMLINK AUTOMÁTICO
########################
link_all_configs() {
    # Recorre todas las carpetas dentro de CONFIG_DIR
    for src_dir in "$CONFIG_DIR"/*; do
        [ -d "$src_dir" ] || continue
        name="$(basename "$src_dir")"
        dest_dir="$HOME/.config/$name"

        backup_file "$dest_dir"
        echo "🔗 Enlazando $dest_dir -> $src_dir"
        ln -sfn "$src_dir" "$dest_dir"
    done
}

########################
# APLICAR CONFIGS
########################
link_all_configs

########################
# SDDM
########################
echo "🎨 Configurando SDDM"

if [ -d "$CONFIG_DIR/sddm/themes" ]; then
    for theme in "$CONFIG_DIR/sddm/themes/"*; do
        [ -e "$theme" ] || continue
        NAME="$(basename "$theme")"
        if [ -e "/usr/share/sddm/themes/$NAME" ]; then
            sudo mv "/usr/share/sddm/themes/$NAME" "$BACKUP_DIR/"
        fi
        sudo cp -r "$theme" /usr/share/sddm/themes/
    done
fi

if [ -e /etc/sddm.conf ]; then
    sudo mv /etc/sddm.conf "$BACKUP_DIR/"
fi

sudo cp "$CONFIG_DIR/sddm/sddm.conf" /etc/sddm.conf
sudo systemctl enable sddm

########################
# FINAL
########################
echo "✅ Kofe-Rice instalado correctamente"
echo "📦 Backups en: $BACKUP_DIR"
echo "🔁 Reinicia o cierra sesión"
