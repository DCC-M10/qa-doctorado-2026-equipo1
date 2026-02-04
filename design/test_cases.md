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

- Strings vacíos: `""`
- Strings con solo espacios: `" "`
- Tipos cruzados: número donde se espera string, string donde se espera boolean
- Fechas: ISO válido vs `"not-a-date"`

---

## Payload base válido (P0)

Este payload fue aceptado empíricamente por el SUT (HTTP 200/201) y se utiliza como base para derivar los casos.

```json
{
  "activo": false,
  "imagen": "https://images-na.ssl-images-amazon.com/images/I/91jvZUxquKL._AC_SL1500_.jpg",
  "usuarioId": "333",
  "titulo": "The Legend of Zelda 3",
  "descripcion": "La nueva Aventura de Zelda 2",
  "plataforma": "Nintendo 2",
  "fecha": "2026-01-22T19:52:38.834Z"
}
