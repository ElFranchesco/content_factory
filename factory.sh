#!/bin/bash

# Script maestro: crear + publicar

COMMIT_MSG=${1:-"Publicación automática desde factory.sh"}
OUT_DIR="$HOME/output/final"

# Crear carpeta de salida si no existe
mkdir -p "$OUT_DIR"

echo "🎬 Generando video..."
./create.sh "$OUT_DIR"
if [ $? -ne 0 ]; then
  echo "❌ Error al generar el video. Revisa create.sh."
  exit 1
fi

echo "🚀 Publicando en GitHub..."
./publish.sh "$COMMIT_MSG"
if [ $? -ne 0 ]; then
  echo "❌ Error al publicar el video. Revisa publish.sh."
  exit 1
fi

echo "✅ Flujo completo terminado: video creado en $OUT_DIR y publicado."
