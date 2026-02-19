#!/usr/bin/env bash
# Script de Inicio con Docker Compose - Games Shop + MongoDB

set -e

echo "🚀 Iniciando Games Shop usando Docker Compose..."
echo ""

API_IMAGE="jmostajo/ts-api-rest-master-ts-api-rest:v1"
MONGO_IMAGE="jmostajo/mongo:v1"

API_CONTAINER="ts-api-rest"
MONGO_CONTAINER="mongo-db"

COMPOSE_FILE="docker-compose.yml"

# =========================
# Verificar Docker
# =========================
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker no está en ejecución. Inicia Docker primero."
    exit 1
fi

# =========================
# Generar docker-compose.yml
# =========================
echo "📄 Generando archivo docker-compose.yml..."

cat <<EOF > ${COMPOSE_FILE}
version: "3.7"

services:

  ${MONGO_CONTAINER}:
    image: ${MONGO_IMAGE}
    container_name: ${MONGO_CONTAINER}
    ports:
      - "27017:27017"
    environment:
      MONGO_INITDB_ROOT_USERNAME: mongoadmin
      MONGO_INITDB_ROOT_PASSWORD: mongopass
    command: --auth
    volumes:
      - mongo_data:/data/db
    networks:
      - api-network
    restart: unless-stopped

  ${API_CONTAINER}:
    image: ${API_IMAGE}
    container_name: ${API_CONTAINER}
    ports:
      - "8000:8000"
    depends_on:
      - ${MONGO_CONTAINER}
    networks:
      - api-network
    volumes:
      - api-files:/app/build/public
    restart: unless-stopped

volumes:
  mongo_data:
  api-files:

networks:
  api-network:
    driver: bridge

EOF

echo "✅ Archivo docker-compose.yml generado."
echo ""

# =========================
# Levantar contenedores
# =========================
echo "📦 Descargando imágenes (si no existen)..."
docker compose pull

echo "▶️  Levantando contenedores..."
docker compose up -d --build

# =========================
# Esperar inicio
# =========================
echo "⏳ Esperando inicialización..."
sleep 8

# =========================
# Verificar ejecución
# =========================
if docker inspect -f '{{.State.Running}}' ${API_CONTAINER} 2>/dev/null | grep -q true; then
    echo ""
    echo "✅ Games Shop iniciado correctamente."
    echo "🌐 API: http://localhost:8000"
    echo "🗄 MongoDB: localhost:27017"
    exit 0
else
    echo "❌ Falló el inicio del contenedor."
    docker compose logs --tail 20
    exit 1
fi
