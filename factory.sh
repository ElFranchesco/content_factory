#!/bin/bash

# Script maestro: crear + publicar

COMMIT_MSG=${1:-"Publicación automática desde factory.sh"}

echo "🎬 Generando video..."
./create.sh
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

echo "✅ Flujo completo terminado: video creado y publicado."
