#!/usr/bin/env bash

echo "Realizando verificación de salud..."

CONTAINER="ts-api-rest"
HEALTH_URL="http://localhost:8000/api/v1/juegos"

# Verificar contenedor
if ! docker inspect -f '{{.State.Running}}' $CONTAINER 2>/dev/null | grep -q true; then
    echo "❌ El contenedor no está en ejecución"
    exit 1
fi

echo "Contenedor en ejecución. Verificando endpoint..."

# Retry hasta 5 intentos
for i in {1..5}; do
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $HEALTH_URL)
    
    if [[ "$HTTP_STATUS" == "200" || "$HTTP_STATUS" == "401" ]]; then
        echo "✅ Aplicación responde (HTTP $HTTP_STATUS)"
        exit 0
    fi
    
    echo "Intento $i fallido (HTTP $HTTP_STATUS). Reintentando..."
    sleep 2
done

echo "❌ Aplicación no responde correctamente"
docker logs $CONTAINER --tail 20
exit 1
