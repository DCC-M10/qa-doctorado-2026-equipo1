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

