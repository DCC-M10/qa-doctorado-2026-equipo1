# Estrategia de Pruebas Basada en Riesgo (Semana 3)

## Propósito

El propósito de esta estrategia es priorizar las actividades de prueba del sistema con base en los riesgos de calidad más críticos identificados. Se busca reducir la incertidumbre sobre la seguridad, robustez y disponibilidad del API mediante evidencia concreta, reproducible y vinculada a escenarios claros. La estrategia conecta explícitamente riesgo, escenario, evidencia y riesgo residual.

## Alcance (por ahora)
**Cubre:**

Esta estrategia cubre pruebas técnicas del API REST ejecutado en entorno local con Docker, enfocadas en: 

- Control de acceso (Q2)
- Manejo de errores (Q4)
- Disponibilidad básica del servicio (Q3)

**No cubre todavía:**

No cubre por ahora:

- Pruebas de carga a gran escala.
- Seguridad avanzada (penetration testing).
- Validaciones en entornos productivos.

## Regla de priorización y desempate (R3 - R4)

En la matriz de riesgos se presentan los riegos priorizados de los cuales se saca el Top 3, sin embargo, existe un empate entre los riesgos R3 y R4 los cuales tienen el mismo score (12), se aplica una regla de desempate explícita priorizando el riesgo que bloquea la operación básica del sistema. Un fallo de disponibilidad (R3) vuelve el sistema inutilizable, un fallo de performance (R4) normalmente degrada la experiencia, pero el sistema sigue funcionando. Por impacto operativo y criticidad del atributo R3 es Top 3 y R4 queda inmediatamente después.
  
## Top 3 riesgos priorizados (matriz: `risk/risk_matrix.csv`)
| Riesgo (ID) | Por qué es Top | Escenario | Evidencia (Semana 3) | Oráculo mínimo | Riesgo Residual |
|------|----------------|-----------|-----------|---------|-----------------|
| R1 – Acceso no autorizado | Compromete datos y operaciones críticas y tiene alta probabilidad por fallas de configuración | Q2 | `evidence/week3/security_results.csv` + `security_results.txt` | Requests sin token o rol válido deben ser rechazados (401/403) | Pueden existir rutas no cubiertas o configuraciones futuras incorrectas |
| R2 – Error 500 con inputs válidos | Afecta funcionalidad básica y ya fue observado empíricamente | Q4 | `evidence/week3/robustness_results.csv` + `robustness_summary.txt`| Inputs válidos no deben generar error 500 | Persisten combinaciones de datos no probadas |
| R3 – Servicio no disponible | Impide cualquier uso del sistema y es plausible en entornos Docker locales | Q4 | `evidence/week3/availability_results.csv` + `availability_summary.txt` | Endpoint responde correctamente tras arranque | Fallas posibles ante cambios de entorno o dependencias |


## Reglas de evidencia (disciplina mínima)

- Toda la evidencia se almacena en la carpeta `evidence/week3/`.
- Cada evidencia debe poder reproducirse mediante un comando o script documentado.
- El oráculo mínimo es binario: la prueba pasa o falla según el comportamiento esperado.

## Riesgo residual (declaración)

A pesar de la ejecución de pruebas enfocadas en los riesgos priorizados, persiste riesgo residual debido a escenarios no cubiertos, configuraciones alternativas del entorno y combinaciones de entradas que no han sido ejercitadas. La evidencia reduce la incertidumbre, pero no elimina completamente la posibilidad de fallos fuera del alcance definido.


## Validez (amenazas y límites)

- **Validez interna:** la evidencia generada está directamente relacionada con los riesgos y escenarios definidos.
- **Validez de constructo:** los riesgos representan atributos reales de calidad del producto desde una perspectiva técnica.
- **Validez externa:** los resultados son aplicables a APIs REST similares ejecutadas en entornos locales y académicos.


