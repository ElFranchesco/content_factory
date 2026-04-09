#!/bin/bash

# Script para publicar automáticamente en GitHub y limpiar la carpeta final
# Uso: ./publish.sh "Mensaje del commit"

# Verifica que se haya pasado un mensaje
if [ -z "$1" ]; then
  echo "❌ Debes ingresar un mensaje de commit."
  echo "Ejemplo: ./publish.sh 'Nuevo video generado'"
  exit 1
fi

# Agregar solo los archivos dentro de la carpeta final/
git add final/

# Crear commit con el mensaje proporcionado
git commit -m "$1"

# Empujar a la rama main
git push origin main

# Si el push fue exitoso, eliminar los archivos de final/
if [ $? -eq 0 ]; then
  rm -rf final/*
  echo "✅ Publicación completada en GitHub y carpeta final/ limpiada."
else
  echo "⚠️ Hubo un error en el push, no se borraron los archivos."
fi
