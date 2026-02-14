#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="../evidence/week5"
mkdir -p "${OUT_DIR}"

RUNLOG="${OUT_DIR}/RUNLOG.md"
{
  echo "# RUNLOG - Semana 5"
  echo ""
  echo "- Fecha: $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
  echo "- Comando: ci/run_quality_gate.sh"
  echo ""
  echo "## Pasos ejecutados"
} > "${RUNLOG}"

echo "- Iniciar SUT (Docker)" >> "${RUNLOG}"
#./setup/run_sut.sh

echo "- Healthcheck" >> "${RUNLOG}"
../setup/healthcheck_sut.sh

echo "- Check 1 — Disponibilidad básica del servicio" >> "${RUNLOG}"
../scripts/quality_scenario_04_availability_week3.sh

echo "- Check 2 — Casos sistemáticos" >> "${RUNLOG}"
../scripts/systematic_cases.sh

echo "- Check 3 — Control de acceso básico" >> "${RUNLOG}"
../scripts/quality_scenario_02_week3.sh

# Copiar evidencia generada por scripts existentes hacia week5 (sin modificar scripts)
cp -f ../evidence/week3/availability_results.csv "${OUT_DIR}/availability_results.csv"
cp -f ../evidence/week3/availability_summary.txt "${OUT_DIR}/availability_summary.txt"
cp -f ../evidence/week4/results.csv "${OUT_DIR}/systematic_results.csv"
cp -f ../evidence/week4/summary.txt "${OUT_DIR}/systematic_summary.txt"
cp -f ../evidence/week3/security_results.csv "${OUT_DIR}/security_results.csv"
cp -f ../evidence/week3/security_summary.txt "${OUT_DIR}/security_summary.txt"

echo "✅ Evidencia copiada en ${OUT_DIR}/"

SUMMARY="${OUT_DIR}/SUMMARY.md"
{
  echo "# Resumen - Semana 5 (Quality Gate)"
  echo ""
  echo "## Evidencia generada"
  echo "- Check 1 — Disponibilidad básica del servicio: ${OUT_DIR}/availability_results.csv"
  echo "- Check 2 — Casos sistemáticos: ${OUT_DIR}/systematic_results.csv"
  echo "- Check 3 — Control de acceso básico: ${OUT_DIR}/security_results.csv"
  echo ""
  echo "## Nota"
  echo "Este gate prioriza checks deterministas (alta senal / bajo ruido)."
} > "${SUMMARY}"

echo "" >> "${RUNLOG}"
echo "## Evidencia producida" >> "${RUNLOG}"
echo "- ${SUMMARY}" >> "${RUNLOG}"
echo "- ${OUT_DIR}/availability_results.csv" >> "${RUNLOG}"
echo "- ${OUT_DIR}/systematic_results.csv" >> "${RUNLOG}"
echo "- ${OUT_DIR}/security_results.csv" >> "${RUNLOG}"

echo "✅ Quality gate completado. Evidencia en ${OUT_DIR}/"
