#!/bin/bash
# Script de Detención de la Aplicación Games Shop

echo "Deteniendo aplicación Games Shop..."

# Detener y eliminar el contenedor de Games Shop
if docker ps | grep -q ts-api-rest; then
    echo "Deteniendo contenedor de Games Shop..."
    docker stop ts-api-rest
    echo "Eliminando contenedor de Games Shop..."
    docker rm ts-api-rest
    echo "Games Shop detenido exitosamente"
else
    echo "El contenedor de Games Shop no está en ejecución"
fi

# Limpiar imágenes huérfanas (opcional)
echo "Limpiando..."
docker image prune -f > /dev/null 2>&1

echo "Limpieza completada"