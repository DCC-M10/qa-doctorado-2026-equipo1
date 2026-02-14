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
# Generar docker-compose.yml
# =========================
echo "📝 Generando docker-compose.yml..."

cat <<EOF > $COMPOSE_FILE
version: '3.7'

services:

  ts-api-rest:
    container_name: ts-api-rest
    build: .
    ports:
      - "8000:8000"
    volumes:
      - api-files:/app/build/public
    networks:
      - api-network
    depends_on:
      - mongodb-server

  mongodb-server:
    image: mongo
    container_name: ts-api-mongo
    ports:
      - "27017:27017"
    environment:
      MONGO_INITDB_ROOT_USERNAME: mongoadmin
      MONGO_INITDB_ROOT_PASSWORD: mongopass
    command: --auth
    volumes:
      - api-mongo:/data/db
    networks:
      - api-network

  mongo-express:
    image: mongo-express
    container_name: ts-api-mongo-empress
    ports:
      - "8081:8081"
    networks:
      - api-network
    depends_on:
      - mongodb-server
    environment:
      ME_CONFIG_MONGODB_ADMINUSERNAME: mongoadmin
      ME_CONFIG_MONGODB_ADMINPASSWORD: mongopass
      ME_CONFIG_MONGODB_SERVER: mongodb-server

volumes:
  api-files:
  api-mongo:

networks:
  api-network:
    driver: bridge
EOF

echo "✅ docker-compose.yml generado correctamente."
echo ""

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
