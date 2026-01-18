#!/bin/bash

echo "======================================"
echo " Iniciando SUT: ts-api-rest"
echo "======================================"

# Verificar si Docker está instalado
if ! command -v docker &> /dev/null; then
  echo "Docker no está instalado. Abortando."
  exit 1
fi

# Verificar si Docker Compose está disponible
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
  echo "Docker Compose no está disponible. Abortando."
  exit 1
fi

# Iniciar el SUT
echo "Levantando contenedores..."
docker compose up -d

if [ $? -eq 0 ]; then
  echo "SUT iniciado correctamente."
else
  echo "Error al iniciar el SUT."
  exit 1
fi
