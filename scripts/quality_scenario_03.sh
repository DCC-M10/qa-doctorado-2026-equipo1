#!/usr/bin/env bash
# Script de Integridad de Persistencia de Datos para Games Shop
# 
# Escenario Q3: Integridad de Persistencia de Datos (Data integrity)
# 
# Este script atiende al escenario Q3 validando Integridad de Persistencia de Datos.
#
# Estímulo: Secuencia de operaciones y Verificaciones posteriores mediante consultas de lectura.
# Entorno: API en entorno de pruebas con **almacenamiento MongoDB** activo.
# Respuesta: Después de cada operación, el recurso debe reflejar el estado esperado.
# Medida (falsable): Resultados de las consultas `GET /juegos/:id` después de cada operación.
# Evidencia: evidence/week2/persistence_results.csv y evidence/week2/persistence_summary.txt
#
# Los resultados se guardan en evidence/week2/

set -euo pipefail

echo "Escenario Q3: Integridad de Persistencia de Datos"
echo "====================================================="
echo ""
# =========================
# Configuración
# =========================
OUTPUT_DIR="../evidence/week2"
BASE_URL="http://localhost:8000"
API_URL="${BASE_URL}/api/v1/juegos"
RESULT_FILE="${OUTPUT_DIR}/persistence_results.json"
SUMMARY_FILE="${OUTPUT_DIR}/persistence_summary.txt"

VALID_TOKEN="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjp7ImlkIjoiNjk3MjdmYTMyNTcwY2NmOWQ0MzhiMDJmIiwicm9sZSI6IkFETUlOIiwibm9tYnJlIjoiSm9yZ2UgQWRtaW4iLCJlbWFpbCI6Imptb3N0YWpvYWRtaW4xQHRlc3QuY29tIiwiZmVjaGEiOiIyMDI2LTAxLTIyVDE5OjUwOjU5LjU0OFoiLCJjcmVhdGVkQXQiOiIyMDI2LTAxLTIyVDE5OjUwOjU5LjU1MloiLCJ1cGRhdGVkQXQiOiIyMDI2LTAxLTIyVDE5OjUwOjU5LjU1MloifSwiaWF0IjoxNzY5MTExNDcwLCJleHAiOjE3NjkxMTUwNzB9.VxADtk1Dy6sQbTjZq9zPoZcHx3jU0A-TWUlEF51N-ac"

GAME_PAYLOAD='{
  "titulo": "The Legend of Zelda 3",
  "descripcion": "La nueva Aventura de Zelda 2",
  "plataforma": "Nintendo 2",
  "imagen": "https://images-na.ssl-images-amazon.com/images/I/91jvZUxquKL._AC_SL1500_.jpg",
  "usuarioId": "333"
}'

mkdir -p "${OUTPUT_DIR}"

# =========================
# Create
# =========================
CREATE_RESPONSE=$(curl -s -X POST "${API_URL}" \
  -H "Authorization: Bearer ${VALID_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "${GAME_PAYLOAD}")

GAME_ID=$(echo "${CREATE_RESPONSE}" | sed -n 's/.*"id"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')

if [[ -z "${GAME_ID}" ]]; then
  echo "ERROR: No se pudo obtener GAME_ID"
  exit 1
fi

# =========================
# Read
# =========================
READ_RESPONSE=$(curl -s -X GET "${API_URL}/${GAME_ID}")

# =========================
# Delete
# =========================
DELETE_HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE "${API_URL}/${GAME_ID}" \
  -H "Authorization: Bearer ${VALID_TOKEN}")

# =========================
# Verify delete
# =========================
VERIFY_HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "${API_URL}/${GAME_ID}")

# =========================
# Evidencia técnica
# =========================
cat <<EOF > "${RESULT_FILE}"
{
  "create": ${CREATE_RESPONSE},
  "read": ${READ_RESPONSE},
  "delete_http_code": "${DELETE_HTTP_CODE}",
  "verify_after_delete_http_code": "${VERIFY_HTTP_CODE}"
}
EOF

# =========================
# Evaluación automática
# =========================
RESULT="PASS"

[[ "${DELETE_HTTP_CODE}" != "200" && "${DELETE_HTTP_CODE}" != "204" ]] && RESULT="FAIL"
[[ "${VERIFY_HTTP_CODE}" != "404" ]] && RESULT="FAIL"

# =========================
# Resumen
# =========================
cat <<EOF > "${SUMMARY_FILE}"
Escenario Q3 — Persistencia y Consistencia de Datos
==================================================

Endpoint:
- ${API_URL}

Resultados:
- ID creado: ${GAME_ID}
- DELETE HTTP: ${DELETE_HTTP_CODE} (esperado 200/204)
- GET post-delete: ${VERIFY_HTTP_CODE} (esperado 404)

Resultado final: ${RESULT}
EOF

echo "================================"
echo "Persistencia"
echo "================================"
echo "Resultado final: ${RESULT}"
echo ""
echo "Evidencias generadas:"
echo " - ${RESULT_FILE}"
echo " - ${SUMMARY_FILE}"

# =========================
# Falsabilidad explícita
# =========================
if [[ "${RESULT}" == "FAIL" ]]; then
  read -p "Presione ENTER para cerrar la ventana..."
  exit 1
fi

read -p "Presione ENTER para cerrar la ventana..."
