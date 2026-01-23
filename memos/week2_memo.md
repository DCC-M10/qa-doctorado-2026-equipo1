# Memo de Progreso - Semana 2

**Fecha**: 24/01/2026  \
**Equipo**: Equipo 1  \
**Semana**: 2 de 8

## Objetivos de la semana
- Convertir “calidad” en afirmaciones **falsables y medibles** mediante escenarios (estímulo–entorno–respuesta–medida).
- Definir un conjunto mínimo de **4 escenarios de calidad** aplicables al SUT (Game Shop).
- Implementar scripts para recolectar evidencia reproducible (rendimiento, seguridad, integridad y robustez).
- Generar y versionar evidencias (CSV/JSON/TXT) con trazabilidad a comandos.

## Logros
- Escenarios de calidad definidos y documentados en `quality/scenarios.md` (Q1–Q4).
- Pruebas de Rendimiento de Endpoints CRUD simulando peticiones concurrentes de Lectura a GET /api/v1/juegos contra la API.
- Script de Seguridad de Autenticación y Autorización con Acceso sin token a rutas con protección, Acceso con token incorrecto o expirado y Acceso con token válido y con rol suficiente (si aplica) a POST /api/v1/juegos.
- Pruebas de Integridad de Persistencia de Datos (Data Integrity) mediante una secuencia de operaciones.
- Pruebas de Robustez de la API frente a datos inválidos (Robustness) enviando múltiples solicitudes POST a /api/v1/juegos con datos inválidos.
- Evidencias generadas y organizadas en `evidence/week2/` para revisión reproducible.

## Evidencia principal
- Escenarios y métricas: `quality/scenarios.md`.
- Pruebas de Rendimiento de Endpoints CRUD:
  - `scripts/quality_scenario_01.sh`
  - `evidence/week2/performance_result.csv`, `evidence/week2/performance_summary.txt`
- Script de Seguridad de Autenticación y Autorización:
  - `scripts/quality_scenario_02.sh`
  - `evidence/week2/security_result.csv`, `evidence/week2/security_result.txt`
- Pruebas de Integridad de Persistencia de Datos
  - `scripts/quality_scenario_03.sh`
  - `evidence/week2/persistence_result.csv`, `evidence/week2/persistence_summary.txt`
- Evidencia de robustez:
  - `scripts/quality_scenario_04.sh`
  - `evidence/week2/robustness_result.csv`, `evidence/week2/robustness_summary.txt`
 
## Retos y notas
- Variabilidad de latencia en pruebas de rendimiento:
Las métricas obtenidas en performance_result.csv muestran dispersión asociada a la ejecución en entorno local (máquina del equipo, carga concurrente, Docker). Los resultados son válidos como evidencia comparativa y falsable, pero no extrapolables directamente a producción sin control de infraestructura y cargas estables.
- Definición de oráculos en escenarios de robustez:
En las pruebas de datos inválidos (quality_scenario_04.sh), se adoptó como oráculo mínimo la condición “HTTP status != 200”, evitando asumir códigos concretos (400, 404, 422) que dependen de la implementación del framework y del middleware de validación.
- Estado del sistema y persistencia:
Las pruebas de integridad (quality_scenario_03.sh) pueden verse afectadas por ejecuciones previas (registros existentes, caché, warm-up). Esta dependencia del estado se documenta explícitamente como amenaza a la validez de los resultados.
- Dependencia de configuración de seguridad:
Los resultados del escenario de seguridad (quality_scenario_02.sh) dependen de la configuración actual de autenticación, expiración de tokens y roles. Cambios en estas reglas invalidan comparaciones históricas si no se versionan junto a la evidencia.

## Lecciones aprendidas
- La calidad se operacionaliza mediante escenarios medibles:
Convertir atributos abstractos (rendimiento, seguridad, robustez, integridad) en escenarios estímulo–entorno–respuesta–medida permitió definir expectativas falsables (p. ej., latencia máxima, rechazo de accesos no autorizados, no-200 ante datos inválidos).
- Evidencia reproducible reduce ambigüedad:
Versionar scripts (scripts/quality_scenario_0X.sh) junto con sus salidas (CSV/TXT) en evidence/week2/ facilita auditoría, réplica y discusión técnica basada en datos, no en percepciones.
- Oráculos simples son más robustos:
La adopción de oráculos mínimos (p. ej., “no éxito” en entradas inválidas o accesos no autorizados) evitó debates innecesarios sobre detalles de implementación y mantuvo el foco en la verificación de requisitos de calidad.
- Separar pruebas de calidad de pruebas funcionales:
Los escenarios no validan lógica de negocio detallada, sino propiedades observables del sistema, alineándose con el objetivo de reducir incertidumbre sobre la calidad global del SUT.

## Próximos pasos (Semana 3) - (Potenciales pasos, a ser discutidos con el equipo)
- Elaborar una matriz de riesgo y derivar cobertura priorizada (riesgo → pruebas → evidencia).
- Formalizar reglas de oráculo y casos de prueba en `design/test_cases.md` y `design/oracle_rules.md`.
- Definir criterios de aceptación (entry/exit) y una estrategia de pruebas ligera basada en riesgo.
- Extender la evidencia para incluir estabilidad (repeticiones) o disponibilidad básica (múltiples checks) si el equipo lo considera relevante.

---

**Preparado por**: Equipo 1  \
**Próxima revisión**: Semana 3
