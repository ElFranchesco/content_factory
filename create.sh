#!/bin/bash

IMG_DIR="$HOME/input/imagenes"
AUD_DIR="$HOME/input/audios"
OUT_DIR="$HOME/final"
OUTPUT_VIDEO="$OUT_DIR/output_video.mp4"

if [ ! -d "$IMG_DIR" ] || [ ! -d "$AUD_DIR" ]; then
  echo "Error: faltan las carpetas de entrada (imagenes o audios)."
  exit 1
fi

mkdir -p "$OUT_DIR"

# Crear un archivo de lista con todas las imágenes
ls "$IMG_DIR"/*.{jpg,jpeg,png,webp} 2>/dev/null | sort | while read f; do
  echo "file '$f'"
done > imagenes.txt

# Generar slideshow desde la lista
ffmpeg -y -f concat -safe 0 -i imagenes.txt \
       -vf "scale=1280:720,format=yuv420p,fps=1" \
       -c:v libx264 temp_video.mp4

# Concatenar audios en un solo archivo
cat "$AUD_DIR"/*.mp3 > temp_audio.mp3

# Unir video + audio
ffmpeg -y -i temp_video.mp4 -i temp_audio.mp3 \
       -c:v copy -c:a aac "$OUTPUT_VIDEO"

# Limpiar temporales
rm temp_video.mp4 temp_audio.mp3 imagenes.txt

echo "✅ Video generado en: $OUTPUT_VIDEO"
