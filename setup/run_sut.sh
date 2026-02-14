#!/usr/bin/env bash
# Script de Inicio - Games Shop (API + Mongo + Mongo Express)

set -e

COMPOSE_FILE="docker-compose.yml"

echo "🚀 Iniciando Games Shop con Docker Compose..."
echo ""

# =========================
# Verificar Docker
# =========================
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker no está en ejecución. Inicia Docker primero."
    exit 1
fi

# =========================
# Verificar existencia de docker-compose.yml
# =========================
if [ ! -f "$COMPOSE_FILE" ]; then
    echo "❌ No se encontró $COMPOSE_FILE en el directorio actual."
    exit 1
fi

# =========================
# Build de la API
# =========================
echo "🔨 Construyendo imagen de la API..."
docker compose build

# =========================
# Levantar servicios
# =========================
echo "📦 Levantando servicios..."
docker compose up -d

# =========================
# Esperar inicialización
# =========================
echo "⏳ Esperando inicialización de servicios..."
sleep 10

# =========================
# Verificar contenedores
# =========================
echo "🔍 Verificando estado de contenedores..."

SERVICES=("ts-api-rest" "ts-api-mongo" "ts-api-mongo-empress")

for SERVICE in "${SERVICES[@]}"; do
    if docker inspect -f '{{.State.Running}}' $SERVICE 2>/dev/null | grep -q true; then
        echo "✅ $SERVICE está en ejecución"
    else
        echo "❌ $SERVICE no está corriendo"
        docker compose logs --tail 20
        exit 1
    fi
done

# =========================
# Verificar salud de la API
# =========================
echo ""
echo "🌐 Verificando endpoint HTTP..."

HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8000)

if [[ "$HTTP_STATUS" == "200" || "$HTTP_STATUS" == "401" ]]; then
    echo "✅ API responde correctamente (HTTP $HTTP_STATUS)"
else
    echo "⚠️  API responde con HTTP $HTTP_STATUS"
    echo "Mostrando últimos logs de la API:"
    docker logs ts-api-rest --tail 20
    exit 1
fi

echo ""
echo "======================================"
echo "🎉 Games Shop iniciado correctamente"
echo "======================================"
echo "🌐 API:           http://localhost:8000"
echo "🗄 MongoDB:       localhost:27017"
echo "📊 Mongo Express: http://localhost:8081"
echo ""
echo "Usuario Mongo: mongoadmin"
echo "Password Mongo: mongopass"
echo ""

exit 0
