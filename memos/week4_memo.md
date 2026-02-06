# Memo de Progreso - Semana 4

**Fecha**: 07/02/2026  \
**Equipo**: Equipo 1  \
**Semana**: 4 de 8

## Objetivos de la semana

- Seleccionar un endpoint del SUT como objeto explícito de prueba.
- Diseñar casos de prueba sistemáticos utilizando una técnica formal (EQ/BV) y definir reglas de oráculo.
- Implementar una ejecución reproducible para generar evidencia versionada.
- Documentar el método de diseño y sus límites (amenazas a la validez).


## Logros

- **Endpoint seleccionado:** POST /api/v1/juegos como objeto único de prueba.
- **Oráculos definidos:** reglas mínimas y estrictas documentadas en design/oracle_rules.md.
- **Casos sistemáticos diseñados:** ≥12 casos derivados explícitamente de Equivalencia de Clases (EQ) y Valores Límite (BV), documentados en design/test_cases.md.
- **Ejecución reproducible implementada:** script scripts/systematic_cases.sh que ejecuta los casos, aplica oráculos y decide pass/fail.
- **Evidencia generada y organizada:** resultados agregados y evidencia por caso almacenados en evidence/week4/.
- **Reporte metodológico producido:** análisis del diseño, cobertura y amenazas a la validez documentado en reports/week4_report.md.

## Evidencia principal

- **Oráculos:** design/oracle_rules.md
- **Casos sistemáticos:** design/test_cases.md
- **Ejecución reproducible:** scripts/systematic_cases.sh
- **Evidencia Week 4:**
    - evidence/week4/results.csv
    - evidence/week4/summary.txt
    - evidence/week4/<TC>_response.json|txt
    - evidence/week4/RUNLOG.md
- **Reporte metodológico:** reports/week4_report.md


## Retos y notas

- La validación del endpoint POST /api/v1/juegos depende del contrato del payload (campos obligatorios, tipos y rangos), lo que introduce variabilidad en los códigos de error retornados (400, 422).
- Para evitar suposiciones sobre reglas internas de negocio, los oráculos mínimos se basan únicamente en:
    - Ausencia de errores 5xx,
    - No retorno de éxito ante payloads inválidos,
    - Respuestas estructuradas no HTML.
- Los oráculos estrictos (estructura completa del recurso creado) se mantienen como observación adicional y no como condición mínima de aprobación.


## Lecciones aprendidas

- El uso de EQ/BV permite justificar cada caso de prueba desde el dominio de entrada, reduciendo arbitrariedad.
- Separar oráculos mínimos vs estrictos facilita decisiones defendibles sin depender de datos internos o persistencia.
- La ejecución reproducible con evidencia versionada mejora la auditabilidad y revisión por terceros.
- Limitar el alcance a un único endpoint hace explícito qué se prueba y qué no, fortaleciendo la validez del diseño.

## Próximos pasos (Semana 5) - (Potenciales pasos, a ser discutidos con el equipo)

- Integrar los casos sistemáticos con priorización por riesgo definida en semanas anteriores.
- Repetir casos críticos para observar estabilidad y detectar posibles comportamientos flakey.
- Definir criterios de salida (exit criteria) para el endpoint según atributos de calidad priorizados.
- Evaluar la extensión del diseño a otros endpoints relacionados del dominio juegos.

---

**Preparado por**: Equipo 1  \
**Próxima revisión**: Semana 5
