#!/bin/bash

# -------------------------------
# Instalador completo para entorno Hyprland
# Incluye yay, UFW, Waybar, Hyprshot, audio, brillo, Bluetooth, etc.
# -------------------------------

set -e  # Detener en errores

echo "⏳ Actualizando sistema base..."
sudo pacman -Syu

# -------------------------------
# Instalar yay si no existe
# -------------------------------
if ! command -v yay &> /dev/null; then
  echo "📦 yay no encontrado. Instalando desde AUR..."
  sudo pacman -S --needed base-devel git
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  cd ..
  rm -rf yay
else
  echo "✅ yay ya está instalado."
fi

# -------------------------------
# Instalar paquetes oficiales
# -------------------------------
echo "📦 Instalando paquetes oficiales..."
sudo pacman -S ufw waybar pavucontrol stow nwg-look starship flatpak \
  pipewire pipewire-audio pipewire-pulse wireplumber alsa-utils \
  bluez bluez-utils brightnessctl pamixer

# -------------------------------
# Activar UFW
# -------------------------------
echo "🛡 Activando UFW..."
sudo systemctl enable --now ufw

# -------------------------------
# Activar Bluetooth
# -------------------------------
echo "📶 Habilitando Bluetooth..."
sudo systemctl enable --now bluetooth

# -------------------------------
# Activar servicios de audio PipeWire
# -------------------------------
echo "🔊 Habilitando servicios de audio..."
systemctl --user enable --now wireplumber.service

# -------------------------------
# Instalar paquetes AUR con yay
# -------------------------------
echo "✨ Instalando paquetes desde AUR..."
yay -S hyprshot swaync hyprlock hypridle hyprpaper

# -------------------------------
# Requisitos para temas SDDM
# -------------------------------
echo "🎨 Instalando dependencias para temas SDDM..."
sudo pacman -S qt5-graphicaleffects qt5-quickcontrols2

# -------------------------------
# Habilitar Flatpak
# -------------------------------
echo "🔧 Habilitando Flatpak..."
sudo systemctl enable --now flatpak

# -------------------------------
# Fin
# -------------------------------
echo ""
echo "✅ Todo listo. ¡Entorno Hyprland completamente preparado con audio, brillo y Bluetooth!"
