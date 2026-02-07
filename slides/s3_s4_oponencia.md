# Guía del Oponente — Revisión bisemanal (Semanas 3 y 4)

**Rol:** realizar una crítica metodológica breve y útil sobre el trabajo del equipo que presenta.  
**Enfoque:** razonamiento, trazabilidad y defendibilidad. **No** evaluar cantidad de pruebas ni cantidad de endpoints.

**Tiempo total:** 6 minutos  
- 1 min: Fortalezas  
- 3 min: Preguntas críticas  
- 2 min: Recomendaciones accionables

---

## 1) Estructura de la intervención (plantilla)

### A. Fortalezas (máx. 2)
- Fortaleza 1: La identificación y priorización de riesgos de calidad se sustenta en un marco reconocido (ISO 31000), lo que aporta rigor metodológico, trazabilidad en la evaluación de impacto y probabilidad, y una base objetiva para enfocar las pruebas en los riesgos más críticos del producto.
- Fortaleza 2: El uso de un análisis de riesgos Swift permite una identificación temprana y colaborativa de riesgos de calidad, facilitando decisiones rápidas y bien enfocadas, sin sacrificar sistematicidad, y alineando el esfuerzo de pruebas con las áreas de mayor impacto potencial en el producto.

### B. Preguntas críticas (2–3 preguntas)
- Pregunta 1 (Semana 3 - riesgo): ¿Los oráculos mínimos definidos para los riesgos R01–R03 (no 5xx, p95 ≤ 2.0 s, consistencia y esquema válido) son suficientes para reducir el riesgo más crítico en el contexto evaluado, o dejan exposiciones relevantes sin cubrir (p. ej., carga, concurrencia o estados transitorios) que afectan la validez de la priorización?
- Pregunta 2 (Semana 3 - trazabilidad/evidencia): ¿Puede proveer la trazabilidad entre 1 riesgo, casos de prueba y evidencia de ejecución, de manera que se pueda rastrear hasta su resultado de prueba?
- Pregunta 3 (Semana 4 - oráculo/diseño): ¿Las reglas de oráculo definidas para POST /store/order cubren de forma suficiente las clases de equivalencia y valores límite relevantes (quantity, status, shipDate) sin introducir supuestos implícitos que puedan invalidar las pruebas ante variaciones legítimas del contrato o la implementación?

### C. Recomendaciones accionables (máx. 2)
- Recomendación 1:Registrar en una plantilla formal de matriz de riesgo cada riesgo con su cálculo de impacto/probabilidad y referencias a casos de prueba relacionados.
- Recomendación 2: Definir y documentar oráculos explícitos para cada funcionalidad crítica, incluyendo ejemplos de resultados esperados y no esperados, y agregar estos oráculos a la suite de pruebas automatizadas para validación repetible.

---

## 2) Lista de verificación rápida (Semanas 3 y 4)

### Semana 3 — Estrategia basada en riesgo
**Verificar en la presentación:**
- [X] Top 3 riesgos están justificados (impacto/probabilidad/score y razón breve)
- [X] Existe trazabilidad explícita: **riesgo → escenario → evidencia → oráculo**
- [X] La evidencia está referenciada con rutas del repo (ej.: `evidence/week3/...`)
- [] Se declara el **riesgo residual** (qué queda fuera y por qué)

**Preguntas de ejemplo:**
- ¿Qué evidencia haría **falsa** su afirmación de reducción de riesgo (falsación)?
- ¿Por qué estos 3 riesgos y no otros? ¿Qué criterio del material teórico sustenta esa decisión?
- ¿El riesgo residual está explícitamente aceptado o solo omitido?

---

### Semana 4 — Diseño sistemático + oráculos
**Verificar en la presentación:**
- [X] Se eligió 1 objeto de prueba (endpoint/función) y se justifica
- [X] Técnica sistemática declarada (EQ/BV o pairwise) y coherente con los casos
- [X] Hay ≥ 5 reglas de oráculo (mínimas vs estrictas)
- [X] Casos y oráculos son trazables a evidencia (ej.: `evidence/week4/...`)
- [ ] Se reconoce al menos 1 ambigüedad y cómo se resolvió

**Preguntas de ejemplo:**
- ¿Qué parte del oráculo es “mínima” (segura) y cuál es “estricta”? ¿Por qué?
- ¿Cómo aseguran que sus casos son “sistemáticos” y no ad-hoc?
- ¿Qué escenario/riesgo de Semana 3 motivó (o se relaciona con) el objeto de prueba elegido?

---
