#!/bin/bash

# --- Este script detecta el reproductor y usa el título para identificar YouTube ---

PLAYER_STATUS=$(playerctl status 2>/dev/null)
METADATA_FORMAT="{{ artist }} - {{ title }}"
METADATA=$(playerctl metadata --format "$METADATA_FORMAT" 2>/dev/null)
PLAYER_NAME=$(playerctl shell metadata --format "{{ playerName }}" 2>/dev/null)
ICON=""
CLASS=""

# 1. Lógica de Detección
if [ "$PLAYER_STATUS" = "Playing" ]; then
    
    # -------------------------------------------------------------
    # A) LÓGICA ESPECÍFICA PARA NAVEGADORES (YouTube)
    # Buscamos las palabras "YouTube" o "YouTube Music" en el metadato
    # -------------------------------------------------------------
    if [[ "$PLAYER_NAME" =~ "firefox" || "$PLAYER_NAME" =~ "chrome" || "$PLAYER_NAME" =~ "chromium" ]]; then
        if [[ "$METADATA" =~ "YouTube" || "$METADATA" =~ "YouTube Music" ]]; then
            ICON="" # Icono de YouTube
            CLASS="youtube-specific" # CLASE PARA ROJO ESPECÍFICO
        else
            ICON="" # Icono genérico si es otro contenido web
            CLASS="web-generic" # CLASE PARA COLOR NEUTRO
        fi
        
    # -------------------------------------------------------------
    # B) LÓGICA ESPECÍFICA PARA SPOTIFY
    # -------------------------------------------------------------
    elif [ "$PLAYER_NAME" = "spotify" ]; then
        ICON="" # Icono de Spotify
        CLASS="spotify-active" # CLASE PARA VERDE SPOTIFY
        
    # -------------------------------------------------------------
    # C) OTROS REPRODUCTORES (VLC, MPV)
    # -------------------------------------------------------------
    else
        ICON="" 
        CLASS="other-active" 
    fi

    # 2. Generar la salida JSON (Reproduciendo)
    printf '{"text": "%s %s", "class": "%s", "tooltip": "%s - Reproduciendo"}' "$ICON" "$METADATA" "$CLASS" "$METADATA"
    
elif [ "$PLAYER_STATUS" = "Paused" ]; then
    # Si está pausado, imprime el icono de pausa y usa la clase 'paused'
    printf '{"text": "⏸ %s", "class": "paused %s", "tooltip": "%s - Pausado"}' "$METADATA" "$CLASS" "$METADATA"
else
    # Si no hay reproductor activo, imprime un JSON vacío
    echo ""
fi