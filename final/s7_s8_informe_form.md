# Informe breve — Estado del arte — Grupo 1
**Tema:** IA para análisis de fallos y calidad operativa: triage, RCA y observabilidad  
**Pregunta guía:** ¿Cómo puede la IA mejorar el triage, el análisis de causa raíz (RCA) y la observabilidad sin comprometer confiabilidad, auditabilidad y gobernanza?  
**Fuentes analizadas:** 15  
**Tesis principal:** La IA mejora significativamente la velocidad y reducción de ruido en operaciones, pero solo genera valor sostenible cuando está integrada a prácticas disciplinadas de observabilidad, con supervisión humana y gobernanza explícita.

---

## Slide 1 — Contexto y propósito
- La creciente complejidad de arquitecturas distribuidas (microservicios, cloud-native) incrementa el volumen de señales operativas y supera la capacidad humana de análisis manual, es por esto de la importancia de incorporar  la IA en los procesos de análisis de fallos y calidad operativa del software.
- Este tema aborda los siguientes problemas: Reducción del MTTR, clasificación eficiente de incidentes, identificación de causa raíz y disminución del ruido operacional.
- Con la incorporación de la IA, nos permite priorizar, correlacionar y diagnosticar incidentes en tiempo casi real con menor intervención manual.

---

## Slide 2 — Pregunta guía y alcance
- Pregunta guía: ¿Cómo integrar IA en triage y RCA manteniendo confiabilidad, explicabilidad y control organizacional?
- Incluye:
  1) Triage automatizado de incidentes.
  2) RCA asistido por correlación multi-señal.
  3) Anomaly detection en observabilidad. 
- No incluye:
  1) Generación automática de pruebas.
  2) Seguridad ofensiva o IA generativa para código.
- Definiciones mínimas (si aplica, 2 términos): 
  1) **Triage**: Clasificación y priorización inicial de incidentes.
  2) **RCA (Root Cause Analysis)**: Identificación sistemática de la causa subyacente de un fallo.

---

## Slide 3 — Método de revisión
- Estrategia de búsqueda: Revisión dirigida de estándares internacionales, literatura académica en ingeniería de software (ICSE) y reportes industriales en AIOps y SRE.
- Criterios de inclusión: 
  1) Aplicación directa a operaciones reales.
  2) Evidencia empírica o marco normativo formal.
  3) Publicaciones 2015–2024.
- Criterios de exclusión: 
  1) Opinión sin respaldo técnico.
  2) Casos puramente comerciales sin evidencia metodológica.
- Tipos de fuente usados:
  Industria / Estándar / Estudio académico.

---

## Slide 4 — Panorama: mapa de hallazgos

- Hallazgo A: La IA reduce MTTR pero introduce sesgos históricos (IDs: S1, S9, S14)
- Hallazgo B: Correlación multi-señal mejora RCA inicial pero no prueba causalidad (IDs: S1, S10, S12)
- Hallazgo C: Anomaly detection depende críticamente de baseline estable (IDs: S11, S12)
- Hallazgo D: Automation bias es un riesgo organizacional real (IDs: S14, S2)
- Hallazgo E: Sin disciplina en observabilidad, la IA no genera valor (IDs: S1, S3)

---

## Slide 5 — Hallazgo clave 1
- Qué afirma: El triage automatizado reduce tiempo de clasificación y MTTR, pero hereda sesgos de datos históricos.
- Evidencia principal (IDs): S1, S9
- Implicación práctica: 
  1) Implementar clasificación asistida, no autónoma.
  2) Medir impacto en MTTR real, no solo precisión del modelo.
- **Condiciones de aplicabilidad:** Dataset histórico suficientemente amplio y balanceado.

---

## Slide 6 — Hallazgo clave 2
- Qué afirma: La correlación automática de logs, métricas y trazas mejora la hipótesis inicial de RCA, pero no garantiza causalidad.
- Evidencia principal (IDs): S10, S12
- Implicación práctica: 
  1) Usar IA como generador de hipótesis.
  2) Exigir validación humana antes de cierre de incidente.
- **Condiciones de aplicabilidad:** Instrumentación consistente (logs estructurados y trazabilidad distribuida).

---

## Slide 7 — Hallazgo clave 3
- Qué afirma: La detección de anomalías produce alto valor solo cuando existe estabilidad operativa y definición clara de SLOs.
- Evidencia principal (IDs): S11, S1
- Implicación práctica: 
  1) Definir SLOs antes de entrenar modelos.
  2) Auditar falsos positivos y negativos trimestralmente.
- Condiciones de aplicabilidad: Sistemas con métricas históricas consolidadas.

---

## Slide 8 — Marco aplicable
- Marco 1: National Institute of Standards and Technology – AI Risk Management Framework → Aporte concreto: gestión de riesgo, monitoreo continuo y explicabilidad (ID: S2)  
- Marco 2: International Organization for Standardization – ISO/IEC 42001 → Aporte concreto: gobernanza organizacional de sistemas IA (ID: S4)  
- Marco 3: International Organization for Standardization – ISO/IEC 25010 → Aporte concreto: marco de calidad (confiabilidad y mantenibilidad) (ID: S3)

---

## Slide 9 — Límites, riesgos y trade-offs 
- Límite 1: La IA no identifica causas fuera del espacio de entrenamiento (unknown unknowns).
- Riesgo 1: Automation bias y sobreconfianza en sugerencias del modelo.
- Trade-off 1: Se gana velocidad operativa vs se sacrifica profundidad analítica inicial.
- Mitigación: Human-in-the-loop obligatorio + auditoría periódica del desempeño del modelo.

---

## Slide 10 — Recomendaciones (implementables) + Top 5
**Recomendaciones implementables:**
- R1: Implementar triage asistido con validación humana obligatoria (IDs: S1, S14)  
- R2: Definir SLOs y métricas de confiabilidad antes de desplegar modelos (IDs: S1, S3)  
- R3: Incorporar monitoreo de desempeño del modelo y auditoría de sesgos (IDs: S2, S4)

**Top 5:**
- 3 ideas/prácticas:
  1) Human-in-the-loop en RCA automatizado.
  2) Observabilidad disciplinada antes de IA.
  3) Medir impacto en MTTR y no solo precisión del modelo.
- 2 anti-patrones/errores a evitar:
  1) Confundir correlación con causalidad.
  2) Automatizar priorización sin auditoría ni explicabilidad.

---

# Matriz de evidencia

| ID  | Tipo      | Fuente (título corto)         | Año  | Idea clave                                     | Qué aporta                | Riesgo/limitación               | Recomendación derivada              |
| --- | --------- | ----------------------------- | ---- | ---------------------------------------------- | ------------------------- | ------------------------------- | ----------------------------------- |
| S1  | Industria | Google SRE Book               | 2016 | MTTR y error budgets estructuran confiabilidad | Marco operativo real      | No aborda IA directamente       | Medir impacto en SLO/MTTR           |
| S2  | Estándar  | NIST AI RMF                   | 2023 | Gestión de riesgo IA                           | Gobernanza formal         | Generalista                     | Auditoría y monitoreo IA            |
| S3  | Estándar  | ISO 25010                     | 2011 | Modelo calidad software                        | Define confiabilidad      | No específico a IA              | Alinear métricas IA a confiabilidad |
| S4  | Estándar  | ISO 42001                     | 2023 | Sistema gestión IA                             | Gobernanza organizacional | Implementación compleja         | Establecer comité IA                |
| S5  | Industria | Microsoft RCA guidance        | 2020 | Postmortem estructurado                        | Formaliza análisis        | Manual intensivo                | IA como soporte                     |
| S6  | Industria | IBM AIOps report              | 2021 | Reducción de incidentes repetitivos            | Evidencia industrial      | Marketing parcial               | Validar con métricas propias        |
| S7  | Industria | Dynatrace observability       | 2022 | Correlación multi-señal                        | RCA más rápido            | Correlación ≠ causalidad        | Validación humana                   |
| S8  | Industria | Datadog anomaly detection     | 2022 | Baseline crítico                               | Reduce ruido              | Falsos positivos                | Ajustar umbrales dinámicos          |
| S9  | Industria | IBM AIOps case study          | 2021 | Triage automatizado reduce tiempo              | Caso real                 | Dependencia de datos históricos | Supervisión continua                |
| S10 | Industria | Dynatrace Davis AI            | 2022 | Análisis causal automatizado                   | Hipótesis rápidas         | Opacidad algorítmica            | Exigir explicabilidad               |
| S11 | Industria | Datadog engineering blog      | 2021 | Anomalías dependen del baseline                | Práctica real             | Alta sensibilidad a cambios     | Definir SLOs previos                |
| S12 | Estudio   | Log Anomaly Detection (ICSE)  | 2018 | ML detecta patrones anómalos                   | Evidencia empírica        | Concept drift                   | Reentrenamiento periódico           |
| S13 | Estudio   | Mining Metrics for RCA        | 2019 | Métricas ayudan a RCA                          | Base cuantitativa         | Dependencia de datos            | Validación cruzada                  |
| S14 | Estudio   | Schäferling – Gov. ADM        | 2023 |  IA pública impacta derechos                   | Marco legal comparado     | Poco enfoque técnico.           | Complementar con enfoque técnico    |
| S15 | Industria | Azure Reliability             | 2021 | Disciplina en incident mgmt                    | Operación real            | No IA específica                | Integrar IA sin sustituir proceso   |


# Fuente secundaria:
| ID  | Tipo      | Fuente (título corto)         | Año  | Idea clave                                     | Qué aporta                | Riesgo/limitación               | Recomendación derivada              |
| --- | --------- | ----------------------------- | ---- | ---------------------------------------------- | ------------------------- | ------------------------------- | ----------------------------------- |
| S16 | Estudio   | Automation Bias (Parasuraman) | 1997 | Humanos sobreconfían en automatización         | Riesgo organizacional     | Contexto previo a IA moderna    | Human-in-the-loop                   |
