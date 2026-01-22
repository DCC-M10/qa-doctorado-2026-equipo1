#!/usr/bin/env bash
# Script de Rendimiento de Endpoints para Games Shop
# 
# Escenario Q1: Rendimiento de Endpoints CRUD (Performance)
# 
# Este script atiende al escenario Q1 verificando el Rendimiento de Endpoints.
#
# Estímulo: Se simulan 30 peticiones concurrentes de lectura (GET /api/v1/juegos)
# Entorno: API desplegada en entorno de pruebas con la base de datos MongoDB activa y configuraciones estándar (dev/prod).
# Respuesta: La API debe procesar las solicitudes sin fallos de error 5xx.
# Medida (falsable): Tiempo medio de respuesta por tipo de operación y porcentaje de errores. Lecturas: tiempo medio ≤ 500 ms. Tasa de éxito ≥ 99 % para todas las peticiones.
# Evidencia: evidence/week2/openapi.json y evidence/week2/openapi_http_code.txt
#
# Los resultados se guardan en evidence/week2/

set -euo pipefail

echo "Escenario Q1: Rendimiento de Endpoints CRUD"
echo "==========================================="
echo ""

# =========================
# Configuración
# =========================
OUTPUT_DIR="../evidence/week2"
BASE_URL="http://localhost:8000"
API_URL="${BASE_URL}/api/v1/juegos"
REQUESTS=30

# Umbrales (criterios de aceptación)
MAX_AVG_MS=500
MAX_P95_MS=800
MIN_SUCCESS_RATE=99

RESULT_FILE="${OUTPUT_DIR}/performance_results.csv"
SUMMARY_FILE="${OUTPUT_DIR}/performance_summary.txt"

# =========================
# Preparación
# =========================
mkdir -p "${OUTPUT_DIR}"

echo "request_id,response_time_ms,http_code" > "${RESULT_FILE}"

echo "Configuración:"
echo "  - URL: ${API_URL}"
echo "  - Requests: ${REQUESTS}"
echo "  - Umbral promedio (ms): ${MAX_AVG_MS}"
echo "  - Umbral P95 (ms): ${MAX_P95_MS}"
echo "  - Tasa mínima éxito (%): ${MIN_SUCCESS_RATE}"
echo ""

# =========================
# Ejecución de pruebas
# =========================
echo "Ejecutando pruebas de rendimiento..."

for i in $(seq 1 "$REQUESTS"); do
  START=$(date +%s%3N)
  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "${API_URL}")
  END=$(date +%s%3N)

  RESPONSE_TIME=$((END - START))
  echo "${i},${RESPONSE_TIME},${HTTP_CODE}" >> "${RESULT_FILE}"
done

# =========================
# Cálculo de métricas
# =========================
AVG_TIME=$(awk -F',' 'NR>1 {sum+=$2; count++} END {print int(sum/count)}' "${RESULT_FILE}")

P95_TIME=$(awk -F',' 'NR>1 {print $2}' "${RESULT_FILE}" \
  | sort -n \
  | awk -v p=0.95 '{
      a[NR]=$1
    }
    END {
      idx=int(NR*p);
      if (idx<1) idx=1;
      print a[idx]
    }')

TOTAL_REQUESTS=$(awk 'END {print NR-1}' "${RESULT_FILE}")
SUCCESS_REQUESTS=$(awk -F',' 'NR>1 && $3 ~ /^2/ {count++} END {print count+0}' "${RESULT_FILE}")
SUCCESS_RATE=$(awk -v s="$SUCCESS_REQUESTS" -v t="$TOTAL_REQUESTS" 'BEGIN {printf "%.2f", (s/t)*100}')

# =========================
# Evaluación automática
# =========================
RESULT="PASS"

if [ "$AVG_TIME" -gt "$MAX_AVG_MS" ]; then
  RESULT="FAIL"
fi

if [ "$P95_TIME" -gt "$MAX_P95_MS" ]; then
  RESULT="FAIL"
fi

if (( $(echo "$SUCCESS_RATE < $MIN_SUCCESS_RATE" | bc -l) )); then
  RESULT="FAIL"
fi

# =========================
# Evidencia
# =========================
cat <<EOF > "${SUMMARY_FILE}"
Escenario Q1 — Rendimiento de Endpoints CRUD
============================================

Endpoint: ${API_URL}
Total de solicitudes: ${TOTAL_REQUESTS}

Métricas:
- Tiempo promedio (ms): ${AVG_TIME}
- Percentil 95 (ms):    ${P95_TIME}
- Tasa de éxito (%):    ${SUCCESS_RATE}

Criterios:
- Promedio <= ${MAX_AVG_MS} ms
- P95 <= ${MAX_P95_MS} ms
- Éxito >= ${MIN_SUCCESS_RATE} %

Resultado final: ${RESULT}
EOF

echo ""
echo "================================"
echo "Resultados de Validación"
echo "================================"
echo "Tiempo promedio: ${AVG_TIME} ms"
echo "P95:             ${P95_TIME} ms"
echo "Tasa de éxito:   ${SUCCESS_RATE} %"
echo "Resultado:       ${RESULT}"
echo ""
echo "Evidencias generadas:"
echo "  - ${RESULT_FILE}"
echo "  - ${SUMMARY_FILE}"

# Falsabilidad explícita para CI
if [ "$RESULT" = "FAIL" ]; then
  exit 1
fi
read -p "Presione ENTER para cerrar la ventana..."

