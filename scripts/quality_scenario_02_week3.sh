#!/usr/bin/env bash
# Script de Seguridad de Autenticación y Autorización para Games shop
# 
# Escenario Q2: Seguridad de Autenticación y Autorización (Security)
# 
# Este script atiende al escenario Q2 verificando la Seguridad de Autenticación y Autorización de la tienda
#
# Estímulo: Acceso sin token a rutas con protección
# Entorno: API en entorno de pruebas con **JWT** configurado y políticas de autorización activas.
# Respuesta: La API debe rechazar accesos no autorizados y permitir accesos válidos.
# Medida (falsable): Las solicitudes **no autenticadas** o **no autorizadas** retornan **401** o **403**, según corresponda.
# Evidencia: evidence/week2/security_results.csv y evidence/week2/security_results.txt
#
# Los resultados se guardan en evidence/week2/
set -euo pipefail

echo "Escenario Q2: Seguridad de Autenticación y Autorización"
echo "====================================================="
echo ""

# =========================
# Configuración
# =========================
OUTPUT_DIR="../evidence/week3"
BASE_URL="http://localhost:8000"
API_URL="${BASE_URL}/api/v1/juegos/"

RESULT_FILE="${OUTPUT_DIR}/security_results.csv"
SUMMARY_FILE="${OUTPUT_DIR}/security_summary.txt"

# Token válido (previamente obtenido)
VALID_TOKEN="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjp7ImlkIjoiNjk3ZTVkNmZlMDhkOTc4NjI1ZjIyMGFlIiwicm9sZSI6IkFETUlOIiwibm9tYnJlIjoiSm9yZ2UgQWRtaW4iLCJlbWFpbCI6Imptb3N0YWpvYWRtaW5AdGVzdC5jb20iLCJmZWNoYSI6IjIwMjYtMDEtMzFUMTk6NTI6MTUuODM3WiIsImNyZWF0ZWRBdCI6IjIwMjYtMDEtMzFUMTk6NTI6MTUuODQ3WiIsInVwZGF0ZWRBdCI6IjIwMjYtMDEtMzFUMTk6NTI6MTUuODQ3WiJ9LCJpYXQiOjE3Njk4ODk0NTksImV4cCI6MTc2OTg5MzA1OX0.3mjvdAv0q-cl8vwLIMioUWd9-OhpqqWvjnc-8BAAMI8"

GAME_PAYLOAD='{
  "titulo": "The Legend of Zelda 2",
  "descripcion": "La nueva Aventura de Zelda 2",
  "plataforma": "Nintendo",
  "imagen": "https://images-na.ssl-images-amazon.com/images/I/91jvZUxquKL._AC_SL1500_.jpg",
  "usuarioId": "111"
}'

# =========================
# Preparación
# =========================
mkdir -p "${OUTPUT_DIR}"
echo "test_case,http_code" > "${RESULT_FILE}"

echo "Configuración:"
echo "  - URL Base: ${BASE_URL}"
echo "  - Endpoint: /api/v1/juegos"
echo "  - Directorio de salida: ${OUTPUT_DIR}"
echo ""

# =========================
# Ejecución de pruebas
# =========================

# Caso 1: Sin token
echo "Caso 1: Acceso sin token"
CODE_NO_TOKEN=$(curl -s -o /dev/null -w "%{http_code}" -X POST "${API_URL}" \
  -H "Content-Type: application/json" \
  -d "${GAME_PAYLOAD}")
echo "POST_without_token,${CODE_NO_TOKEN}" >> "${RESULT_FILE}"

# Caso 2: Token inválido
echo "Caso 2: Acceso con token inválido"
CODE_INVALID_TOKEN=$(curl -s -o /dev/null -w "%{http_code}" -X POST "${API_URL}" \
  -H "Authorization: Bearer invalidtoken" \
  -H "Content-Type: application/json" \
  -d "${GAME_PAYLOAD}")
echo "POST_invalid_token,${CODE_INVALID_TOKEN}" >> "${RESULT_FILE}"

# Caso 3: Token válido
echo "Caso 3: Acceso con token válido"
CODE_VALID_TOKEN=$(curl -s -o /dev/null -w "%{http_code}" -X POST "${API_URL}" \
  -H "Authorization: Bearer ${VALID_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "${GAME_PAYLOAD}")
echo "POST_valid_token,${CODE_VALID_TOKEN}" >> "${RESULT_FILE}"

# =========================
# Evaluación automática
# =========================
RESULT="PASS"

if [[ "${CODE_NO_TOKEN}" != "401" && "${CODE_NO_TOKEN}" != "403" ]]; then
  RESULT="FAIL"
fi

if [[ "${CODE_INVALID_TOKEN}" != "401" && "${CODE_INVALID_TOKEN}" != "403" ]]; then
  RESULT="FAIL"
fi

if [[ "${CODE_VALID_TOKEN}" != "200" && "${CODE_VALID_TOKEN}" != "201" ]]; then
  RESULT="PASS"
fi

# =========================
# Evidencia resumida
# =========================
cat <<EOF > "${SUMMARY_FILE}"
Escenario Q2 — Seguridad de Autenticación y Autorización
========================================================

Endpoint evaluado:
- POST ${API_URL}

Resultados:
- Sin token:        HTTP ${CODE_NO_TOKEN} (esperado 401/403)
- Token inválido:   HTTP ${CODE_INVALID_TOKEN} (esperado 401/403)
- Token válido:     HTTP ${CODE_VALID_TOKEN} (esperado 200/201)

Resultado final: ${RESULT}
EOF

echo ""
echo "================================"
echo "Resultados de Seguridad"
echo "================================"
echo "Resultado final: ${RESULT}"
echo ""
echo "Evidencias generadas:"
echo "  - ${RESULT_FILE}"
echo "  - ${SUMMARY_FILE}"

# =========================
# Falsabilidad explícita
# =========================
if [[ "${RESULT}" == "FAIL" ]]; then
  exit 1
fi
read -p "Presione ENTER para cerrar la ventana..."
