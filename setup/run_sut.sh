#!/bin/bash
# Script de Inicio de la Aplicación Games Shop

echo "Iniciando aplicación Games Shop..."

# Verificar si Docker está en ejecución
if ! docker info > /dev/null 2>&1; then
    echo "Docker no está en ejecución. Por favor inicia Docker primero."
    exit 1
fi

# Descargar y ejecutar el contenedor de Games Shop
echo "Descargando imagen de Games Shop..."
docker pull jmostajo/ts-api-rest-master-ts-api-rest:v1

echo "Iniciando contenedor de Games Shop..."
docker run -d --name ts-api-rest -p 8000:8000 jmostajo/ts-api-rest-master-ts-api-rest:v1

# Esperar un momento para que el contenedor inicie
sleep 5

# Verificar si el contenedor está en ejecución
if docker ps | grep -q ts-api-rest; then
    echo "Games Shop iniciado exitosamente en http://localhost:8000"
    echo "Documentación de la API disponible en: http://localhost:8000"
else
    echo "Falló al iniciar Games Shop"
    exit 1
fi
