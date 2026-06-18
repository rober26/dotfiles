#!/bin/bash
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
NAME="$DIR/Screenshot_$(date +%Y-%m-%d_%H-%M-%s).png"

if slurp | grim -g - "$NAME"; then
    wl-copy < "$NAME"
    notify-send "Captura de pantalla" "Guardada en Imágenes y copiada al portapapeles" -i "$NAME"
else
    notify-send "Captura" "Se ha cancelado la captura"
fi

