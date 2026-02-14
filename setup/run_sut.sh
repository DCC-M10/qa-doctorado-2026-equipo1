#!/usr/bin/env bash
# Script de Inicio con Docker Compose - Games Shop

set -e

echo "🚀 Iniciando Games Shop usando Docker Compose..."
echo ""

IMAGE_NAME="jmostajo/ts-api-rest-master-ts-api-rest:v1"
CONTAINER_NAME="ts-api-rest-master"
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
version: "3.9"

services:
  ${CONTAINER_NAME}:
    image: ${IMAGE_NAME}
    container_name: ${CONTAINER_NAME}
    ports:
      - "8000:8000"
    restart: unless-stopped
EOF

echo "✅ Archivo docker-compose.yml generado."
echo ""

# =========================
# Levantar contenedor
# =========================
echo "📦 Descargando imagen (si no existe)..."
docker compose pull

echo "▶️  Levantando contenedor..."
docker compose up -d

# =========================
# Esperar inicio
# =========================
sleep 5

# =========================
# Verificar ejecución
# =========================
if docker compose ps | grep -q "${CONTAINER_NAME}"; then
    echo ""
    echo "✅ Games Shop iniciado correctamente."
    echo "🌐 Disponible en: http://localhost:8000"
    exit 0
else
    echo "❌ Falló el inicio del contenedor."
    docker compose logs --tail 20
    exit 1
fi
