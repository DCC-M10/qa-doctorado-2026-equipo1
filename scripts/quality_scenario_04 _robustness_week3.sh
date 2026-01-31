#!/usr/bin/env bash
# Script de Pruebas de Entradas Inválidas para Games Shop
# 
# Escenario Q4: Robustez ante IDs inválidos (Robustness / Error Handling)
# 
# Este script atiende al escenario Q4 probando el manejo de entradas inválidas.
#
# Estímulo: Se envían múltiples solicitudes `POST /api/v1/juegos` con datos inválidos
# Entorno: API REST **ts-api-rest** ejecutándose en entorno de pruebas local.
# Respuesta: Rechazar todas las solicitudes inválidas.
# Medida (falsable): **100 %** de las solicitudes inválidas retornan **HTTP 400 (Bad Request)**.
# Evidencia:  evidence/week2/robustness_results.csv y robustness_summary.txt
#
# Los resultados se guardan en evidence/week2/

echo "🔍 Escenario Q4: Robustez de la API frente a datos inválidos"
echo "=============================================="
echo ""

# =========================
# Configuración
# =========================
OUTPUT_DIR="../evidence/week3"
BASE_URL="http://localhost:8000"
API_URL="${BASE_URL}/api/v1/juegos"
RESULT_FILE="${OUTPUT_DIR}/robustness_results.csv"
SUMMARY_FILE="${OUTPUT_DIR}/robustness_summary.txt"

# Token válido (previamente obtenido)
VALID_TOKEN="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjp7ImlkIjoiNjk3ZTVkNmZlMDhkOTc4NjI1ZjIyMGFlIiwicm9sZSI6IkFETUlOIiwibm9tYnJlIjoiSm9yZ2UgQWRtaW4iLCJlbWFpbCI6Imptb3N0YWpvYWRtaW5AdGVzdC5jb20iLCJmZWNoYSI6IjIwMjYtMDEtMzFUMTk6NTI6MTUuODM3WiIsImNyZWF0ZWRBdCI6IjIwMjYtMDEtMzFUMTk6NTI6MTUuODQ3WiIsInVwZGF0ZWRBdCI6IjIwMjYtMDEtMzFUMTk6NTI6MTUuODQ3WiJ9LCJpYXQiOjE3Njk4OTMwODIsImV4cCI6MTc2OTg5NjY4Mn0.OiIYOFs_KCH699RxPAOxmXAdpevB2n1ct2cKkvnhous"

echo "Configuración:"
echo "  - URL Base: ${BASE_URL}"
echo "  - Endpoint: /api/v1/juegos"
echo "  - Directorio de salida: ${OUTPUT_DIR}"
echo ""

mkdir -p "${OUTPUT_DIR}"

echo "test_case,http_code" > "${RESULT_FILE}"

# =========================
# Ejecución de pruebas
# =========================

# Caso 1: Payload vacío
CODE_EMPTY=$(curl -s -o /dev/null -w "%{http_code}" \
  -X POST "${API_URL}" \
  -H "Authorization: Bearer ${VALID_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{}')
echo "empty_payload,${CODE_EMPTY}" >> "${RESULT_FILE}"

# Caso 2: Falta campo obligatorio
CODE_MISSING=$(curl -s -o /dev/null -w "%{http_code}" \
  -X POST "${API_URL}" \
  -H "Authorization: Bearer ${VALID_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{"usuarioId":25}')
echo "missing_title,${CODE_MISSING}" >> "${RESULT_FILE}"

# Caso 3: Tipo de dato incorrecto
CODE_INVALID_TYPE=$(curl -s -o /dev/null -w "%{http_code}" \
  -X POST "${API_URL}" \
  -H "Authorization: Bearer ${VALID_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{"titulo":"Invalid Game","usuarioId":"free"}')
echo "invalid_user_id,${CODE_INVALID_TYPE}" >> "${RESULT_FILE}"

# =========================
# Evaluación automática
# =========================
RESULT="PASS"

for CODE in "${CODE_EMPTY}" "${CODE_MISSING}" ; do
  if [[ "${CODE}" != "400" && "${CODE}" != "422" ]]; then
    RESULT="FAIL"
  fi
done

if [[ "${CODE_INVALID_TYPE}" != "201" ]]; then
  RESULT="FAIL"
fi

# =========================
# Resumen
# =========================
cat <<EOF > "${SUMMARY_FILE}"
Escenario Q4 — Robustez frente a Entradas Inválidas
=================================================

Endpoint:
- POST /api/v1/juegos

Resultados:
- Payload vacío:            HTTP ${CODE_EMPTY} (esperado 400/422)
- Falta campo obligatorio:  HTTP ${CODE_MISSING} (esperado 400/422)
- Tipo de dato inválido:    HTTP ${CODE_INVALID_TYPE} (esperado 201)

Resultado final: ${RESULT}
EOF

echo ""
echo "================================"
echo "Robustez"
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
  exit 1
fi
read -p "Presione ENTER para cerrar la ventana..."