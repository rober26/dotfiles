#!/bin/bash

# Ruta a tus fondos
WALL_DIR="$HOME/Downloads"

# Escanear imágenes
AVAILABLE_WALLS=$(ls "$WALL_DIR" | grep -E "\.(jpg|jpeg|png|webp)")

if [ -z "$AVAILABLE_WALLS" ]; then
    exit 1
fi

# Rofi con posición ajustada y sin errores de parseo
# Se añade xargs para limpiar espacios/newlines en la selección
SELECTION=$(echo "$AVAILABLE_WALLS" | rofi -dmenu \
    -i \
    -p "🖼️ Selector" \
    -theme-str '
        window { 
            width: 350px; 
            location: north east; 
            anchor: north east; 
            x-offset: -12px; 
            y-offset: 35px; 
            border: 2px; 
            border-color: #7aa2f7; 
            border-radius: 12px; 
            background-color: #1a1b26;
        }
        mainbox { children: [ inputbar, listview ]; padding: 10px; }
        inputbar { background-color: #1a1b26; color: #c0caf5; padding: 4px; children: [ prompt, entry ]; }
        prompt { text-color: #7aa2f7; margin: 0px 5px 0px 0px; }
        entry { text-color: #c0caf5; }
        listview { lines: 6; columns: 1; scrollbar: false; background-color: transparent; }
        element { padding: 6px; border-radius: 6px; }
        element-text { text-color: #a9b1d6; }
        element selected { background-color: #7aa2f7; }
        element selected element-text { text-color: #1a1b26; font-weight: bold; }
    ')

# Limpiamos la selección (quita el newline invisible)
CLEAN_SELECTION=$(echo "$SELECTION" | xargs)

# Si el usuario elige uno, se aplica con swww
if [ -n "$CLEAN_SELECTION" ]; then
    swww img "$WALL_DIR/$CLEAN_SELECTION" --transition-type "wave" --transition-fps 60 --transition-step 90
    echo "$WALL_DIR/$CLEAN_SELECTION" > ~/.cache/current_wallpaper
fi
