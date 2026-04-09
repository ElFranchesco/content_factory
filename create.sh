#!/bin/bash

IMG_DIR="$HOME/input/imagenes"
AUD_DIR="$HOME/input/audios"
OUT_DIR=${1:-"$HOME/output/final"}
OUTPUT_VIDEO="$OUT_DIR/output_video.mp4"

if [ ! -d "$IMG_DIR" ] || [ ! -d "$AUD_DIR" ]; then
  echo "Error: faltan las carpetas de entrada (imagenes o audios)."
  exit 1
fi

mkdir -p "$OUT_DIR"

# Crear lista de imágenes (manejo de espacios en nombres)
rm -f imagenes.txt
for f in "$IMG_DIR"/*.{jpg,jpeg,png,webp}; do
  [ -e "$f" ] || continue
  echo "file '$f'" >> imagenes.txt
done

# Generar slideshow desde la lista
ffmpeg -y -f concat -safe 0 -i imagenes.txt \
       -vf "scale=1280:720,format=yuv420p,fps=1" \
       -c:v libx264 temp_video.mp4

# Crear lista de audios (manejo de espacios en nombres)
rm -f audios.txt
for f in "$AUD_DIR"/*.mp3; do
  [ -e "$f" ] || continue
  base=$(basename "$f" .mp3)
  ffmpeg -y -i "$f" -ar 44100 -ac 2 -c:a pcm_s16le "${base}.wav"
  echo "file '${base}.wav'" >> audios.txt
done

# Concatenar audios WAV en un solo archivo
ffmpeg -y -f concat -safe 0 -i audios.txt -c:a pcm_s16le temp_audio.wav

# Combinar video y audio en el archivo final
ffmpeg -y -i temp_video.mp4 -i temp_audio.wav \
       -c:v copy -c:a aac "$OUTPUT_VIDEO"

# Limpiar temporales
rm -f temp_video.mp4 temp_audio.wav imagenes.txt audios.txt *.wav

echo "✅ Video generado en $OUTPUT_VIDEO"
