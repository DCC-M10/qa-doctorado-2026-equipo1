# RUNLOG — Semana 3

**Fecha**: 2026-01-31  
**SUT**: WebAPI Game Shop (Docker local)  
**Objetivo**: Recopilar evidencia para los Top 3 riesgos (R1–R3) definidos en `risk/risk_matrix.csv`.

## Comandos ejecutados (reproducibles)
> Nota: Los scripts del repositorio generan evidencia en `evidence/week3/`. Para mantener trazabilidad semanal,
> en Semana 3 se **crearon** nuevos scripts con postfijo  `week3` en la carpeta `script`.

1) Seguridad de Autenticación y Autorización (Q2 / Riesgo R1)
- Comando: `./scripts/quality_scenario_02_week3.sh`
- Oráculo:
  Resultados:
  Sin token:        HTTP 401 (esperado 401/403)
  Token inválido:   HTTP 401 (esperado 401/403)
  Token válido:     HTTP 201 (esperado 200/201)
  Resultado final: PASS
- Artefactos: `security_results.csv`, `security_summary.txt`

2) Robustez de la API frente a datos inválidos (Q4 / Riesgo R2)
- Comando: `./scripts/quality_scenario_04_robustness_week3.sh`
- Oráculo:
  Resultados:
  Payload vacío:            HTTP 422 (esperado 400/422)
  Falta campo obligatorio:  HTTP 422 (esperado 400/422)
  Tipo de dato inválido:    HTTP 201 (esperado 201)
  Resultado final: PASS
- Artefactos: `robustness_results.csv`, `robustness_summary.txt`

3) Robustez de la API frente a datos inválidos (Q4 / Riesgo R3)
- Comando: `./scripts/quality_scenario_04_availability_week3.sh`
- Oráculo:
  Resultados:
  Health check posterior:   HTTP 200 (esperado 200)
  Resultado final: PASS
- Artefactos: `availability_results.csv`, `availability_summary.txt`

## Copia a carpeta de semana
- Acción: N/A
- Motivo: N/A
