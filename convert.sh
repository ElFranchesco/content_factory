#!/bin/bash

IMG_DIR="$HOME/input/imagenes"

echo "🔄 Convirtiendo todas las imágenes a PNG..."
cd "$IMG_DIR" || exit

# Convertir cualquier JPG/JPEG/WEBP a PNG
mogrify -format png *.jpg *.jpeg *.webp 2>/dev/null

# Eliminar originales problemáticos
rm -f *.jpg *.jpeg *.webp

echo "✅ Conversión terminada. Solo quedan PNG."
