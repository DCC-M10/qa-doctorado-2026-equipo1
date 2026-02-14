# Quality Gate en Continuous Integration (CI) — (Semana 5) 
  
## Proyecto: Games Shop

## 1. Objetivo del Gate

Este Quality Gate tiene como objetivo reducir la incertidumbre sobre los riesgos críticos priorizados en la Semana 3 (acceso no autorizado, errores 500 con inputs válidos y disponibilidad del servicio) mediante la ejecución automática de chequeos deterministas y trazables en cada integración de código.

El gate no pretende asegurar calidad total, ni cubrir performance avanzado, seguridad profunda o escenarios productivos. Su propósito es bloquear regresiones evidentes en atributos básicos de disponibilidad, robustez y control de acceso, usando oráculos explícitos definidos en la Semana 4.

## 2. Checks del Gate

Se definen cuatro checks alineados a los riesgos Top 3 y al diseño sistemático previo.

### Check 1 — Disponibilidad básica del servicio

**Claim:**  
Tras el arranque del entorno Docker, el servicio API debe estar operativo y responder correctamente a una solicitud válida, sin fallos de infraestructura o indisponibilidad.

**Oráculo (pass/fail):**

- La solicitud GET /api/v1/juegos/{id} devuelve un http_code distinto de timeout o error de conexión (QR1).
- El http_code no debe pertenecer al rango 5xx (OR5).
- La respuesta no debe ser HTML (OR2).

   **Falla si:**
  
     - No hay respuesta.
     - Hay error de conexión.
     - Retorna 5xx.
     - Retorna contenido HTML inesperado.

**Evidencia:**

- `evidence/week5/availability_http_code.txt`
- `evidence/week5/availability_body.json`

**Trazabilidad:**

- Semana 3:
   - R3 – Servicio no disponible
   - risk/risk_matrix.csv
   - risk/test_strategy.md
     
- Semana 4:
   - OR1, OR2 y OR5 (design/oracle_rules.md)

---
### Check 2 — Casos sistemáticos derivados por método (EQ + BV)

**Claim:**  
El conjunto de pruebas sistemáticas definido mediante las técnicas de Equivalencia (EQ) y Valores Límite (BV) debe ejecutarse completamente y evaluarse bajo oráculos explícitos, produciendo evidencia reproducible y una decisión binaria por caso.

Este check evalúa la correcta aplicación del diseño sistemático definido en Semana 4 y asegura que cada caso derivado metodológicamente sea ejecutado y evaluado bajo criterios formales de pass/fail.

**Oráculo (pass/fail):**
Para cada caso definido en design/test_cases.md:

- Debe generarse evidencia con http_code y cuerpo de respuesta (OR1).
- No debe retornar 5xx (OR5).
- No debe retornar HTML (OR2).
- Debe existir una decisión explícita pass/fail por caso.

   **Falla si:**

     - Algún caso no genera evidencia.
     - El script no produce resumen consolidado.
     - Se detecta al menos un FAIL sin justificación documentada.
     - Retorna 5xx o HTML inesperado.

**Evidencia:**

- `evidence/week5/systematic_results.csv`
- `evidence/week5/systematic_summary.txt`

**Trazabilidad:**

- Semana 4:
   - design/test_cases.md
   - design/oracle_rules.md

- Técnica aplicada:
   - Equivalencia (EQ)
   - Valores Límite (BV)

- Relación metodológica:
   - Validación de ejecución completa del diseño sistemático definido previamente
   - Coherencia entre diseño → ejecución → evidencia → decisión automática del Gate

---

### Check 3 — Control de acceso básico

**Claim:**  
Solicitudes sin token o con credenciales inválidas no deben permitir acceso al recurso protegido.

**Oráculo (pass/fail):**
Para solicitudes sin token o con rol inválido:

- http_code ∈ {401, 403}.
- No debe retornar 200.
- No debe retornar 5xx (el rechazo debe ser controlado).
- No debe retornar HTML (OR2).

   **Falla si:**

     - Retorna 200 sin autenticación válida.
     - Retorna 5xx ante solicitud sin credenciales.
     - Retorna HTML inesperado.

**Evidencia:**

- `evidence/week5/security_results.csv`
- `evidence/week5/security_summary.txt`

**Trazabilidad:**

- Semana 3:
   - R1 – Acceso no autorizado
   - risk/test_strategy.md
   - Evidencia base: evidence/week3/security_results.csv
     
- Semana 4:
   - Relación metodológica con oráculos mínimos (OR2, OR5)

---

## 3. Alta señal / Bajo ruido

Estos checks cumplen criterios de confiabilidad porque:

- **Determinismo:** Se basan en códigos HTTP y validación estructural (no HTML, no 5xx), evitando métricas inestables.
- **Oráculos explícitos:** Las reglas OR2–OR5 están formalmente definidas en Semana 4.
- **Repetibilidad:** Los mismos inputs sistemáticos producen el mismo resultado bajo las mismas condiciones.
- **Trazabilidad completa:** Riesgo → escenario → evidencia → oráculo → decisión binaria.

---

## 4. Cómo ejecutar localmente (equivalente a CI)

```bash
make quality-gate (genera evidence/week5/).
