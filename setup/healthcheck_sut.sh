#!/bin/bash
# Script de Verificación de Salud para la Aplicación Games Shop

echo "Realizando verificación de salud en la aplicación Games Shop..."

# Verificar si el contenedor de Docker está en ejecución
if ! docker ps | grep -q ts-api-rest; then
    echo "❌ El contenedor de Games Shop no está en ejecución"
    exit 1
fi

# Verificar si la aplicación está respondiendo
echo "Verificando salud de la aplicación..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8000)

if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "✅ Games Shop está saludable y respondiendo"
    echo "📊 Estado de la aplicación: En ejecución"
    echo "🌐 Endpoint: http://localhost:8000"
    
    # Verificaciones adicionales
    echo "🔍 Estado del contenedor:"
    docker stats --no-stream ts-api-rest | tail -n 1
    #read -p "Presione ENTER para cerrar la ventana..."
    exit 0
else
    echo "❌ Games Shop no está respondiendo (HTTP $HTTP_STATUS)"
    echo "🔧 Verificando logs del contenedor..."
    docker logs ts-api-rest --tail 10
	#read -p "Presione ENTER para cerrar la ventana..."
    exit 1
fi