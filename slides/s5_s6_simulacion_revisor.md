# Evaluación de Propuesta - Equipo 1
**Propuesta evaluada:** (A) — Empresa: Q-Edge Consulting  
**Veredicto:** Aceptar con condiciones

> Regla: Todo punto debe estar **respaldado por la propuesta**.
> Si algo no está en la propuesta, debe ir en "Vacíos" o "Preguntas", no como afirmación.

---

## Slide 1 — Qué ofrece la propuesta (solo hechos del texto)
- Objetivo declarado: Establecer control de calidad continuo en el sistema del cliente y asegurar que el gate sea operativo rápidamente.
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
- Selección Top 3 riesgos para guiar el gate. **Ref:** Sección 4 – Fase 2
- Diseño sistemático con técnicas formales (EQ/BV + pairwise). **Ref:** Sección 4 – Fase 3
- Implementación de gate con 4 checks específicos. **Ref:** Sección 5

### B) Vacíos/ambigüedades que impiden evaluar bien (3-5 puntos)
- Vacío 1: Definición operativa de “robustez básica”  
  **Qué falta exactamente:** No se define estímulo/entorno/respuesta/medida.
  **Por qué importa (1 frase):** Impide evaluar claridad del claim y su verificabilidad.
- Vacío 2: Control de integridad del gate  
  **Qué falta exactamente:** No se menciona verificación de integridad de scripts o artifacts.
  **Por qué importa:** El gate podría ser vulnerable a manipulación (gaming). 
- Vacío 3: Baseline formal para p95  
  **Qué falta exactamente:**  No se especifica cómo se establece ni valida estadísticamente.  
  **Por qué importa:** Riesgo de ruido alto e inestabilidad del gate.
- Vacío 4: Métricas de efectividad del gate  
**Qué falta exactamente:**  No se definen métricas para medir si el gate realmente mejora la calidad (ej. reducción de defectos o regresiones).  
**Por qué importa:** Sin métricas, no se puede demostrar que el gate genera valor real y no solo evidencia operativa.

### C) Preguntas de aclaración al proveedor (2-4 preguntas)
- P1: ¿Qué checks son considerados críticos e innegociables?
- P2: ¿Qué evidencia mínima debe cumplir cada escenario para considerarse válido?
- P3:  ¿Cómo se protege el gate frente a manipulación de evidencia o reducción silenciosa de casos?

---

## Slide 5 — Goodhart / Gaming (solo si se deriva del texto)
> Debe basarse en señales explícitas del documento (ej.: "mantener gate verde", "ajustar umbrales", "excepciones", "reruns", etc.)

- Señal en la propuesta (citar): “El pipeline se aprueba si se cumplen al menos 3 de los 4 checks.”  
  **Referencia:** Sección 5
- Riesgo de gaming (1 frase): Optimizar estratégicamente 3 checks y descuidar uno crítico para mantener el gate verde.
- Consecuencia probable (1 frase): El gate deja de reflejar el riesgo real y puede aprobar versiones con defectos significativos.
- Mitigación/condición (1 frase): Requerir que cualquier check asociado a un riesgo Top 3 sea obligatorio (fail-fast).

---

## Slide 6 - Condiciones para aceptar (solo si el veredicto lo requiere)
> 2-4 condiciones **verificables**. Deben apuntar a corregir debilidades o llenar vacíos.

- C1: Eliminar el criterio 3 de 4 para checks asociados a riesgos Top 3  
  **Cómo se verifica:** Simulación de fallo en un check crítico debe bloquear el pipeline.  
  **Motivo (D# o Vacío #):** D1
- C2: Implementar registro formal versionado de cambios de umbral  
  **Cómo se verifica:** Cómo se verifica: Existencia de archivo tipo gate_change_log.md con fecha, motivo y aprobación.  
  **Motivo:** D4
  
---

## Slide 7 - Veredicto (decisión final)
- Decisión: Aceptar con condiciones
- Justificación (máximo 3 puntos, conectados a D# o Vacíos):
  1) El criterio 3/4 debilita el gate como instrumento de evidencia (D1).
  2) La gobernanza de cambios es insuficiente para evitar degradación progresiva del gate (D4).
  3) No se contemplan mecanismos explícitos contra gaming o manipulación de evidencia (Vacío 2).

