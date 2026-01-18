#!/bin/bash

echo "======================================"
echo " Deteniendo SUT: ts-api-rest"
echo "======================================"

# Detener contenedores
docker compose down

if [ $? -eq 0 ]; then
  echo "SUT detenido correctamente."
else
  echo "Error al detener el SUT."
  exit 1
fi
