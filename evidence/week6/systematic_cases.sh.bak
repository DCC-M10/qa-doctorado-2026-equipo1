#!/usr/bin/env bash
set -euo pipefail

# Semana 4 — Ejecución sistemática de casos para Game Shop
# Endpoint objetivo: GET /api/v1/juegos/{id}
#
# Requisitos:
# - SUT corriendo localmente (por defecto): http://localhost:8000
# - curl disponible
#
# Uso:
#   ./scripts/systematic_cases.sh
#   BASE_URL=http://localhost:8000 ./scripts/systematic_cases.sh
#
# Salidas:
# - evidence/week4/results.csv
# - evidence/week4/summary.txt
# - evidence/week4/<TC_ID>_response.(json|txt)
# - evidence/week4/RUNLOG.md (si no existe, se crea)

BASE_URL="${BASE_URL:-http://localhost:8000}"
API_BASE="${BASE_URL%/}/api/v1/juegos"
OUT_DIR="../evidence/week4"

mkdir -p "${OUT_DIR}"

# Crear RUNLOG si no existe
if [[ ! -f "${OUT_DIR}/RUNLOG.md" ]]; then
  cat > "${OUT_DIR}/RUNLOG.md" <<EOF
# RUNLOG — Semana 4

- Fecha/Hora: $(date -Iseconds)
- Comando: \`BASE_URL=${BASE_URL} ./scripts/systematic_cases.sh\`
- Endpoint: \`GET /api/v1/juegos/{id}\`
- Oráculos: ver \`design/oracle_rules.md\`
EOF
fi

RESULTS="${OUT_DIR}/results.csv"
echo "tc_id,input_id,partition,http_code,oracle_pass,notes,response_file" > "${RESULTS}"

# Función auxiliar: eliminar espacios iniciales y obtener primer carácter
first_non_ws_char() {
  # imprime el primer carácter que no sea espacio en blanco (o vacío)
  local file="$1"
  awk '
    {
      for (i = 1; i <= length($0); i++) {
        c = substr($0, i, 1)
        if (c !~ /[[:space:]]/) { print c; exit }
      }
    }
  ' "$file"
}

# Aplicar oráculos mínimos basados en partición
# OR1: registrado
# OR2: no HTML (primer carácter no vacío != '<')
# OR3: ID inválido no aceptado => http_code != 200
# OR4: ID válido aceptado — comportamiento permitido => http_code en {200,404}
# OR5: No debe retornar 5xx
# OR6: Consistencia semántica cuando hay 200 => si http_code == 200 para {id} numérico, el cuerpo debería incluir un campo "id"
run_case() {
  local tc_id="$1"
  local input_id="$2"
  local partition="$3"

  local url="${API_BASE}/${input_id}"
  local resp_file="${OUT_DIR}/${tc_id}_response.json"

  # Capturar cuerpo + código http
  local http_code
  http_code=$(curl -s -o "${resp_file}" -w "%{http_code}" "${url}" || true)

  local notes=""
  local pass="true"

  # OR2: no HTML
  local c
  c=$(first_non_ws_char "${resp_file}")
  if [[ "${c}" == "<" ]]; then
    pass="false"
    notes="${notes}OR2_fail_html;"
    # renombrar a .txt para reflejar contenido no-json
    mv "${resp_file}" "${OUT_DIR}/${tc_id}_response.txt"
    resp_file="${OUT_DIR}/${tc_id}_response.txt"
  fi

  # OR5: no 5xx
  if [[ "${http_code}" =~ ^5 ]]; then
    pass="false"
    notes="${notes}OR5_fail_5xx;"
  fi

  # Específico por partición
  if [[ "${partition}" == "P1" || "${partition}" == "P2" ]]; then
    # OR3
    if [[ "${http_code}" == "200" ]]; then
      pass="false"
      notes="${notes}OR3_fail_invalid_200;"
    fi
  elif [[ "${partition}" == "P3" ]]; then
    # OR4
    if [[ "${http_code}" != "200" && "${http_code}" != "404" ]]; then
      pass="false"
      notes="${notes}OR4_fail_unexpected_code;"
    fi
    # OR6 (estricta): si 200, reportar si no hay "id"
    if [[ "${http_code}" == "200" ]]; then
      if ! grep -q "\"id\"" "${resp_file}" 2>/dev/null; then
        notes="${notes}OR6_strict_missing_id;"
      fi
    fi
  fi

  echo "${tc_id},${input_id},${partition},${http_code},${pass},${notes},${resp_file}" >> "${RESULTS}"
}

# Casos (deben corresponder a design/test_cases.md)
run_case "TC01" "69855e665c286868739f86aZ" "P1"
run_case "TC02" "69855e665c286868739f86a" "P2"
run_case "TC03" "69855e665c286868739f86a6F" "P2"
run_case "TC04" "6986c174f133b839d0a9f462" "P3"
run_case "TC05" "69855e665c2868687TTTTTTT" "P1"
run_case "TC06" "-9855e665c2868687TTTTTTT" "P1"
run_case "TC07" "69855e665c286868" "P1(BV)"
run_case "TC08" "000000000000000000000000" "P3(BV)"
run_case "TC09" "FFFFFFFFFFFFFFFFFFFFFFFF" "P3(BV)"
run_case "TC10" "69855e665c2.6868739f86a6" "P1"
run_case "TC11" "00000" "P2"
run_case "TC12" "-1" "P3"

# Resumen
total=$(tail -n +2 "${RESULTS}" | wc -l | tr -d ' ')
passed=$(tail -n +2 "${RESULTS}" | awk -F',' '$5=="true"{c++} END{print c+0}')
failed=$(( total - passed ))

cat > "${OUT_DIR}/summary.txt" <<EOF
Semana 4 — Resumen de ejecución sistemática
- Total casos: ${total}
- Pass (oráculo mínimo): ${passed}
- Fail (oráculo mínimo): ${failed}

Archivos:
- results.csv: matriz por caso (código, pass/fail, notas)
- <TC>_response.*: evidencia por caso
EOF

echo "[OK] Semana 4: evidencia generada en ${OUT_DIR}"
#read -p "Presione ENTER para cerrar la ventana..."