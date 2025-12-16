#!/bin/bash

options="Apagar\nReiniciar\nSuspender\nBloquear\nSalir"
chosen=$(echo -e "$options" | wofi --dmenu --prompt "Powermenu")

case "$chosen" in
    Apagar) systemctl poweroff ;;
    Reiniciar) systemctl reboot ;;
    Suspender) systemctl suspend ;;
    Bloquear) hyprlock ;;
    Salir) hyprctl dispatch exit ;;
esac
