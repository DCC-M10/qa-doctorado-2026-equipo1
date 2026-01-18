#!/bin/bash

SUT_URL="http://localhost:3000"

echo "======================================"
echo " Healthcheck SUT: ts-api-rest"
echo "======================================"

# Verificar si curl está instalado
if ! command -v curl &> /dev/null; then
  echo "curl no está instalado. Abortando."
  exit 1
fi

# Realizar petición HTTP
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $SUT_URL)

if [ "$HTTP_STATUS" -eq 200 ]; then
  echo "SUT operativo. Código HTTP: $HTTP_STATUS"
  exit 0
else
  echo "SUT no responde correctamente."
  echo "Código HTTP recibido: $HTTP_STATUS"
  exit 1
fi
