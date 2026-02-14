#!/usr/bin/env bash
# Script de Pruebas de Entradas Inválidas para Games Shop
#
# Escenario Q4: Robustez ante IDs inválidos (Robustness / Error Handling)

echo "🔍 Escenario Q4: Robustez de la API frente a datos inválidos"
echo "=============================================="
echo ""

# =========================
# Configuración
# =========================
OUTPUT_DIR="../evidence/week3"
BASE_URL="http://localhost:8000"
API_URL="${BASE_URL}/api/v1/juegos"
REGISTER_URL="${BASE_URL}/api/v1/user/register"
LOGIN_URL="${BASE_URL}/api/v1/user/login"

RESULT_FILE="${OUTPUT_DIR}/robustness_results.csv"
SUMMARY_FILE="${OUTPUT_DIR}/robustness_summary.txt"

echo "Configuración:"
echo "  - URL Base: ${BASE_URL}"
echo "  - Endpoint Juegos: /api/v1/juegos"
echo "  - Endpoint Register: /api/v1/user/register"
echo "  - Endpoint Login: /api/v1/user/login"
echo ""

mkdir -p "${OUTPUT_DIR}"
echo "test_case,http_code" > "${RESULT_FILE}"

# =========================
# 1️⃣ Registro de usuario
# =========================
echo "Registrando usuario de prueba..."

REGISTER_RESPONSE=$(curl -s -X POST "${REGISTER_URL}" \
  -H "Content-Type: application/json" \
  -d '{
        "nombre": "Jorge Admin",
        "email": "jmostajoadmin@test.com",
        "password": "123-abc.",
        "role": "ADMIN"
      }')

echo "Usuario registrado (si no existía)."

# =========================
# 2️⃣ Login para obtener token
# =========================
echo "Obteniendo token JWT..."

LOGIN_RESPONSE=$(curl -s -X POST "${LOGIN_URL}" \
  -H "Content-Type: application/json" \
  -d '{
        "email": "jmostajoadmin@test.com",
        "password": "123-abc."
      }')

# Extraer token (asumiendo {"token":"...."})
VALID_TOKEN=$(echo "$LOGIN_RESPONSE" | sed -n 's/.*"token":"\([^"]*\)".*/\1/p')

if [[ -z "$VALID_TOKEN" ]]; then
  echo "❌ Error: No se pudo obtener el token."
  echo "Respuesta login:"
  echo "$LOGIN_RESPONSE"
  exit 1
fi

echo "Token obtenido correctamente."
echo "$VALID_TOKEN"
echo ""

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

for CODE in "${CODE_EMPTY}" "${CODE_MISSING}"; do
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