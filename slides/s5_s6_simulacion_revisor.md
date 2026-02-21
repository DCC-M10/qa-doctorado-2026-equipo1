# Evaluación de Propuesta - Equipo 1
**Propuesta evaluada:** (A) — Empresa: Q-Edge Consulting  
**Veredicto:** (Aceptar con condiciones)

> Regla: Todo punto debe estar **respaldado por la propuesta**.
> Si algo no está en la propuesta, debe ir en "Vacíos" o "Preguntas", no como afirmación.

---

## Slide 1 — Qué ofrece la propuesta (solo hechos del texto)
- Objetivo declarado (copiar 1 frase o resumir): Establecer control de calidad continuo combinando escenarios, priorización por riesgo y un quality gate en CI para acelerar la adopción operativa.
  **Referencia:** Sección 1
- Alcance / exclusiones (2+ puntos):
  - Incluye: escenarios (6–10), matriz de riesgos y estrategia Top 3, pruebas sistemáticas (≥12 casos por objeto), oráculos, gate CI con artifacts, guía de mantenimiento. **Ref:** Sección 3  
  - Excluye: pruebas de seguridad especializadas, pruebas de carga a nivel producción, auditoría formal de arquitectura. **Ref:** Sección 3
- Entregables principales (3+ puntos):  
  - Catálogo de escenarios en formato estímulo/entorno/respuesta/medida. **Ref:** Sección Ref: Sección 4 – Fase 1  
  - Documento de estrategia riesgo → escenario → evidencia. **Ref:** Sección Ref: Sección 4 – Fase 2  
  - Quality gate en CI con publicación de artifacts por ejecución. **Ref:** Sección Ref: Sección 4 – Fase 4

---

## Slide 2 - Fortalezas (basadas en texto)
> 3-5 fortalezas. Cada una debe citar una sección.

- F1: Enfoque explícito basado en riesgo  
  **Evidencia en propuesta:** Sección Sección 4 – Fase 2  
  **Por qué es valioso (1 frase):** Por qué es valioso: Alinea cobertura y gate a riesgos priorizados (Top 3), evitando dispersión.
- F2: Uso de diseño sistemático formal (EQ/BV + pairwise)  
  **Evidencia en propuesta:** Sección Sección 4 – Fase 3  
  **Por qué es valioso:** Por qué es valioso: Reduce pruebas ad-hoc y mejora la defendibilidad metodológica.
- F3: Evidencia reproducible y artifacts por ejecución  
  **Evidencia en propuesta:** Sección Sección 4 – Fase 4 y Sección 9  
  **Por qué es valioso:** Por qué es valioso: Permite auditoría y trazabilidad de cada run del gate.
- (Opcional) F4/F5: ___ (mismo formato)

---

## Slide 3 - Debilidades / riesgos (basadas en texto)
> 3-6 debilidades. Marcar severidad: **Crítica / Mayor / Menor**.
> Cada debilidad debe citar una sección de la propuesta.

- D1 (Severidad: Crítica): Criterio 3 de 4 checks para aprobar el gate  
  **Texto/Sección relacionada:** Sección 5  
  **Riesgo/impacto (1 frase):** Puede permitir que un check crítico falle y aun así el pipeline pase, debilitando el gate como instrumento de evidencia.
- D2 (Severidad: Mayor): Oráculos “mínimos” y aplicación flexible  
  **Texto/Sección relacionada:** Sección 4 – Fase 3  
  **Riesgo/impacto:** La falta de criterios formales para endurecer oráculos puede derivar en debilitamiento progresivo del gate.
- D3 (Severidad: Mayor): Reintento automático ante fallo  
  **Texto/Sección relacionada:** Sección 6  
  **Riesgo/impacto:** Puede ocultar fallos intermitentes y reducir la señal del gate.
- D4 (Severidad: Mayor): Gobernanza débil de cambios de umbral  
  **Texto/Sección relacionada:** Sección 7  
  **Riesgo/impacto:**  No se exige registro formal estructurado ni justificación explícita de cambios críticos.

---

## Slide 4 - Cobertura explícita vs vacíos
### A) Lo que la propuesta sí define (3-5 puntos)
- ___ **Ref:** Sección ___
- ___ **Ref:** Sección ___
- ___ **Ref:** Sección ___

### B) Vacíos/ambigüedades que impiden evaluar bien (3-5 puntos)
- Vacío 1: ___  
  **Qué falta exactamente:** ___  
  **Por qué importa (1 frase):** ___
- Vacío 2: ___  
  **Qué falta exactamente:** ___  
  **Por qué importa:** ___
- Vacío 3: ___  
  **Qué falta exactamente:** ___  
  **Por qué importa:** ___

### C) Preguntas de aclaración al proveedor (2-4 preguntas)
- P1: ___
- P2: ___
- (Opcional) P3/P4: ___

---

## Slide 5 — Goodhart / Gaming (solo si se deriva del texto)
> Debe basarse en señales explícitas del documento (ej.: "mantener gate verde", "ajustar umbrales", "excepciones", "reruns", etc.)

- Señal en la propuesta (citar): ___  
  **Referencia:** Sección ___
- Riesgo de gaming (1 frase): ___
- Consecuencia probable (1 frase): ___
- Mitigación/condición (1 frase): ___

---

## Slide 6 - Condiciones para aceptar (solo si el veredicto lo requiere)
> 2-4 condiciones **verificables**. Deben apuntar a corregir debilidades o llenar vacíos.

- C1: ___  
  **Cómo se verifica:** ___  
  **Motivo (D# o Vacío #):** ___
- C2: ___  
  **Cómo se verifica:** ___  
  **Motivo:** ___
- (Opcional) C3/C4: ___ 

---

## Slide 7 - Veredicto (decisión final)
- Decisión: ___
- Justificación (máximo 3 puntos, conectados a D# o Vacíos):
  1) ___ (D# / Vacío #)
  2) ___ (D# / Vacío #)
  3) ___ (D# / Vacío #)

