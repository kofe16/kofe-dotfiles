#!/bin/bash

# -------------------------------
# Instalador completo para entorno Hyprland
# Incluye yay, UFW, Waybar, Hyprshot, etc.
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
# Instalar paquetes oficiales con confirmación
# -------------------------------
echo "📦 Instalando paquetes oficiales..."
sudo pacman -S ufw waybar pavucontrol stow nwg-look starship flatpak

# -------------------------------
# Activar UFW
# -------------------------------
echo "🛡 Activando UFW..."
sudo systemctl enable --now ufw

# -------------------------------
# Instalar paquetes AUR con yay
# -------------------------------
echo "✨ Instalando paquetes desde AUR..."
yay -S hyprshot swaync hyprlock hypridle hyprpaper

# -------------------------------
# Instalar fuentes
# -------------------------------
echo "📚 Instalando fuentes..."
sudo pacman -S ttf-cascadia-nerd lexend-fonts-git ttf-jetbrains-mono-nerd

# -------------------------------
# Requisitos para SDDM con temas
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
echo "✅ Todo listo. ¡Entorno preparado!"