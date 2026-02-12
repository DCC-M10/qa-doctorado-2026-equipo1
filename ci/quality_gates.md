# Quality Gate en Continuous Integration (CI) — Semana 5 
  
## Proyecto: Games Shop

## 1. Objetivo del Gate

Este Quality Gate tiene como objetivo reducir la incertidumbre sobre los riesgos críticos priorizados en la Semana 3 (acceso no autorizado, errores 500 con inputs válidos y disponibilidad del servicio) mediante la ejecución automática de chequeos deterministas y trazables en cada integración de código.

El gate no pretende asegurar calidad total, ni cubrir performance avanzado, seguridad profunda o escenarios productivos. Su propósito es bloquear regresiones evidentes en atributos básicos de disponibilidad, robustez y control de acceso, usando oráculos explícitos definidos en la Semana 4.

## 2. Checks del Gate

Se definen cuatro checks alineados a los riesgos Top 3 y al diseño sistemático previo.

### Check 1 — Disponibilidad básica del servicio (R3)

**Claim:**  
El servicio API está disponible y responde tras el arranque del entorno Docker.

**Oráculo (pass/fail):**

- El endpoint `GET /api/v1/juegos/{id}` responde (cualquier código distinto de timeout/conexión fallida).
- No retorna `5xx` (OR5).

**Evidencia:**

- `evidence/week5/availability_http_code.txt`
- `evidence/week5/availability_body.json`

**Trazabilidad:**

- Semana 3: R3 – Servicio no disponible  
- `risk/risk_matrix.csv`  
- `risk/test_strategy.md`

---

### Check 2 — Robustez ante IDs inválidos (R2 / OR3)

**Claim:**  
IDs que contienen caracteres fuera de `{0-9;A-F;a-f}` no deben ser aceptados como válidos.

**Oráculo (pass/fail):**

- Para cada ID inválido definido sistemáticamente → `http_code != 200`
- No debe retornar `5xx` (OR5).
- No debe retornar HTML (OR2).

**Evidencia:**

- `evidence/week5/invalid_ids_results.csv`
- `evidence/week5/invalid_case_*.json`

**Trazabilidad:**

- Semana 3: R2 – Error 500 con inputs válidos  
- Semana 4: `design/oracle_rules.md` (OR2, OR3, OR5)  
- `design/test_cases.md`

---

### Check 3 — Comportamiento permitido para IDs válidos (OR4)

**Claim:**  
IDs que cumplen la regla formal (hexadecimal, longitud 24) deben retornar comportamiento permitido.

**Oráculo (pass/fail):**

- `http_code ∈ {200, 404}` (OR4)
- No `5xx` (OR5)
- No HTML (OR2)

**Evidencia:**

- `evidence/week5/valid_ids_results.csv`
- `evidence/week5/valid_case_*.json`

**Trazabilidad:**

- Semana 4: `design/oracle_rules.md` (OR4, OR5)
- Técnica EQ + BV definida en `design/test_cases.md`

---

### Check 4 — Control de acceso básico (R1)

**Claim:**  
Solicitudes sin token o con rol inválido deben ser rechazadas.

**Oráculo (pass/fail):**

- Requests sin credenciales → `http_code ∈ {401, 403}`
- No `200` para acceso no autorizado.

**Evidencia:**

- `evidence/week5/security_results.csv`
- `evidence/week5/security_summary.txt`

**Trazabilidad:**

- Semana 3: R1 – Acceso no autorizado  
- `risk/test_strategy.md`  
- Evidencia previa en `evidence/week3/security_results.csv`

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
