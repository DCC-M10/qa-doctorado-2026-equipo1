# Memo de Progreso - Semana 4

**Fecha**: 06/02/2026  \
**Equipo**: Equipo 1  \
**Semana**: 4 de 8

## Objetivos de la semana

- Seleccionar un endpoint del SUT como objeto de prueba para el diseño sistemático.
- Diseñar casos de prueba sistemáticos utilizando técnicas formales (Equivalencia y Valores Límite).
- Definir reglas de oráculo (mínimas, por partición y estrictas) para evaluación objetiva pass/fail.
- Implementar una ejecución reproducible que permita generar evidencia versionada.
- Documentar el método de diseño y explicitar sus límites de validez.


## Logros

- **Endpoint seleccionado:** GET /api/v1/juegos/{id} del sistema Games Shop.

- **Oráculos definidos:**
Reglas de oráculo documentadas en design/oracle_rules.md, distinguiendo:

    - Reglas mínimas (registro, no HTML),

    - Reglas por partición (IDs válidos vs inválidos),

    - Reglas estrictas (no 5xx y consistencia semántica en respuestas 200).

- **Casos sistemáticos diseñados:**
Conjunto de ≥12 casos derivados explícitamente de Equivalencia (EQ) y Valores Límite (BV), documentados en design/test_cases.md.

- **Ejecución reproducible implementada:**
Script de ejecución sistemática que permite repetir los casos y generar evidencia consistente.

- **Evidencia Week 4 generada:**
Evidencia organizada y versionada en evidence/week4/, incluyendo evidencia individual por caso y resultados agregados.

- **Reporte metodológico producido:**
Informe corto del diseño, cobertura y amenazas a la validez documentado en reports/week4_report.md.

## Evidencia principal

- **Reglas de oráculo:** design/oracle_rules.md

- **Casos sistemáticos:** design/test_cases.md

- **Ejecución reproducible:** scripts/systematic_cases.sh

- **Evidencia de ejecución:**

    - evidence/week4/<TC-ID>_response.json

    - evidence/week4/results.csv

    - evidence/week4/summary.txt

    - evidence/week4/RUNLOG.md

- **Reporte metodológico:** reports/week4_report.md


## Retos y notas

- **Dependencia del estado del SUT:**
Un identificador hexadecimal válido (longitud 24) puede retornar 200 o 404 dependiendo de la existencia del recurso.

- **Mitigación aplicada:**
Los oráculos mínimos permiten explícitamente ambos códigos (200, 404) para IDs válidos, evitando suposiciones sobre datos internos.

- **Uso de reglas estrictas:**
La regla de consistencia semántica (OR6) se reporta como chequeo estricto y no como condición mínima de fallo.

## Lecciones aprendidas

- El uso de técnicas sistemáticas (EQ/BV) reduce la arbitrariedad frente a pruebas ad-hoc.

- Separar oráculos mínimos de oráculos estrictos permite mantener falsabilidad sin depender de datos no controlados.

- La evidencia por caso, junto con resultados agregados, facilita la revisión, auditoría y trazabilidad del diseño de pruebas.

- Explicitar los límites del diseño fortalece la validez metodológica del trabajo.


## Próximos pasos (Semana 5) - (Potenciales pasos, a ser discutidos con el equipo)

- Integrar el diseño sistemático con la priorización basada en riesgo desarrollada en semanas anteriores.

- Ampliar la cobertura hacia otros atributos de calidad (robustez, estabilidad).

- Introducir repetición controlada de casos críticos para evaluar estabilidad y detectar flakiness.

- Definir criterios de salida por atributo de calidad priorizado.


---

**Preparado por**: Equipo 1  \
**Próxima revisión**: Semana 5
