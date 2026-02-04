# Casos de prueba sistemáticos — Semana 4 (ts-api-rest)

**Técnica usada:**  
Equivalencia (EQ) + Valores Límite (BV) aplicados al **payload JSON** del endpoint  
`POST /api/v1/juegos`.

---

## Objeto de prueba

**Endpoint:** `POST /api/v1/juegos`

**Qué hace:**  
Crea un recurso “juego” a partir de un payload JSON.

**Por qué es buen candidato:**  
El endpoint presenta alta variabilidad de entradas, validaciones de dominio y riesgo de errores 4xx/5xx, lo que lo hace adecuado para un diseño sistemático.

**Precondición:**  
Las pruebas de validación de entradas se ejecutan con **JWT válido**, para evitar respuestas 401/403 que oculten fallos del payload.

---

## Particiones (EQ)

- **P1 (Payload válido):** todos los campos obligatorios presentes y con tipo esperado.
- **P2 (Payload vacío):** body vacío o ausente.
- **P3 (Campo obligatorio ausente):** falta al menos un campo requerido.
- **P4 (Tipo inválido):** campo presente con tipo incorrecto.
- **P5 (String inválido):** string vacío o solo espacios.
- **P6 (Formato inválido):** formato incorrecto (ej. fecha no válida).

---

## Valores límite (BV) considerados

Los valores límite se definen **por campo**, en función del dominio observado y del comportamiento esperado del SUT.

### Campos string (`titulo`, `descripcion`, `plataforma`, `imagen`)

- `""` → string vacío (límite inferior semántico).
- `" "` → string con solo espacios (contenido no informativo).
- `"A"` → longitud mínima razonable.
- string largo (≥ 255 caracteres) → límite superior práctico.

### Campo booleano (`activo`)

- `true` → valor válido.
- `false` → valor válido.
- `"true"` → tipo inválido (string en lugar de boolean).

### Campo fecha (`fecha`)

- `"2026-01-22T19:52:38.834Z"` → fecha ISO válida (caso nominal).
- `"1970-01-01T00:00:00Z"` → límite inferior conceptual.
- `"not-a-date"` → formato inválido.

### Campo identificador (`usuarioId`)

- `"1"` → valor mínimo válido observado.
- `"0"` → límite inferior sospechoso.
- `"999999"` → valor alto típico.
- `123` → tipo inválido (número en lugar de string).


---

## Formato de evidencia

Cada caso de prueba genera la siguiente evidencia:

- **Evidencia individual por caso:**  
  `evidence/week4/TC-XX_response.json`

- **Registro agregado de la ejecución completa:**  
  - `evidence/week4/results.csv`  
  - `evidence/week4/summary.txt`

## Casos de prueba sistemáticos (≥ 12)

**Referencias a reglas:** ver `design/oracle_rules.md`

| TC-ID | Input (variación sobre P0) | Partición | Expected (oráculo mínimo) | Evidencia esperada |
|------|----------------------------|-----------|----------------------------|--------------------|
| TC01 | Payload completo (P0) | P1 | OR1, OR2, OR3, OR4 | TC01_response.* |
| TC02 | Body vacío | P2 | OR1, OR2, OR3, OR5 | TC02_response.* |
| TC03 | Eliminar campo `titulo` | P3 | OR1, OR2, OR3, OR6 | TC03_response.* |
| TC04 | Eliminar campo `usuarioId` | P3 | OR1, OR2, OR3, OR6 | TC04_response.* |
| TC05 | `"titulo": ""` | P5 (BV) | OR1, OR2, OR3, OR8 | TC05_response.* |
| TC06 | `"titulo": " "` | P5 (BV) | OR1, OR2, OR3, OR8 | TC06_response.* |
| TC07 | `"titulo": 123` | P4 | OR1, OR2, OR3, OR7 | TC07_response.* |
| TC08 | `"activo": "false"` | P4 | OR1, OR2, OR3, OR7 | TC08_response.* |
| TC09 | `"fecha": "not-a-date"` | P6 | OR1, OR2, OR3, OR7 | TC09_response.* |
| TC10 | Eliminar campo `imagen` | P3 (mínimo candidato) | OR1, OR2, OR3, OR6* | TC10_response.* |
| TC11 | Eliminar campo `descripcion` | P3 (mínimo candidato) | OR1, OR2, OR3, OR6* | TC11_response.* |
| TC12 | Eliminar campo `plataforma` | P3 (mínimo candidato) | OR1, OR2, OR3, OR6* | TC12_response.* |

\* En TC10–TC12, si el SUT retorna HTTP 200/201, el campo se considera **no obligatorio**.

## Trazabilidad de casos — Partición y Valores Límite (EQ/BV)

La siguiente tabla muestra explícitamente cómo cada caso de prueba sistemático cubre
una **partición de equivalencia (EQ)** y, cuando aplica, un **valor límite (BV)** concreto.

| TC-ID | Partición (EQ) | Campo afectado | Valor probado | Tipo |
|------|----------------|---------------|---------------|------|
| TC01 | P1 (Payload válido) | Todos | Payload base válido (P0) | EQ |
| TC02 | P2 (Payload vacío) | Body | Payload ausente | EQ |
| TC03 | P3 (Campo ausente) | titulo | Campo eliminado | EQ |
| TC04 | P3 (Campo ausente) | usuarioId | Campo eliminado | EQ |
| TC05 | P5 (String inválido) | titulo | `""` | BV |
| TC06 | P5 (String inválido) | titulo | `" "` | BV |
| TC07 | P4 (Tipo inválido) | titulo | `123` | BV |
| TC08 | P4 (Tipo inválido) | activo | `"false"` | BV |
| TC09 | P6 (Formato inválido) | fecha | `"not-a-date"` | BV |
| TC10 | P3 (Campo ausente) | imagen | Campo eliminado | EQ |
| TC11 | P3 (Campo ausente) | descripcion | Campo eliminado | EQ |
| TC12 | P3 (Campo ausente) | plataforma | Campo eliminado | EQ |

---

## Observación metodológica

- Cada **partición de equivalencia** definida está cubierta al menos una vez.
- Las particiones con mayor riesgo semántico (strings, tipos y formato de fecha)
  incluyen **múltiples valores límite**, lo que hace los casos **falsables**.
- Esta trazabilidad justifica de forma explícita el número de casos (≥ 12) y evita
  interpretaciones de testing ad-hoc.

