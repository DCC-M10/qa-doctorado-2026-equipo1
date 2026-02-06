# Casos de prueba sistemáticos — Semana 4 (Games Shop)

**Técnica usada:**  
Equivalencia (EQ) + Valores Límite (BV) aplicados al **payload JSON** del endpoint  
`GET /api/v1/juegos/{id}`.

---

## Objeto de prueba

**Endpoint:** `GET /api/v1/juegos/{id}`

---

## Particiones (EQ)

- **P1 (No existen en {0-9;A-F;a-f}):** {id} contiene caracteres que no existen en {0-9;A-F;a-f}.
- **P2 (existe en {0-9;A-F;a-f} y longitud ≠ 24):** {id} existen en {0-9;A-F;a-f}, pero longitud ≠ 24.
- **P3 (existe en {0-9;A-F;a-f} y longitud = 24):** {id} existen en {0-9;A-F;a-f}, pero longitud = 24.

---

## Valores límite (BV) considerados

- **Longitudes de IDs cercanas a 24:** 23, 24, 25
- **Formatos extremos válidos:** 000000000000000000000000 , FFFFFFFFFFFFFFFFFFFFFFFF

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
| TC01 | 69855e665c286868739f86aZ | P1 | OR1, OR2, OR3, OR5 | TC01_response.* |
| TC02 | 69855e665c286868739f86a | P2 | OR1, OR2, OR3, OR5 | TC02_response.* |
| TC03 | 69855e665c286868739f86a6F | P2 | OR1, OR2, OR3, OR5 | TC03_response.* |
| TC04 | 69855e665c286868739f86a6 | P3 | OR1, OR2, OR3, OR4, OR6 | TC04_response.* |
| TC05 | 69855e665c2868687TTTTTTT | P1 | OR1, OR2, OR3, OR5 | TC05_response.* |
| TC06 | -9855e665c2868687TTTTTTT | P1 | OR1, OR2, OR3, OR5 | TC06_response.* |
| TC07 | 69855e665c286868 | P1 (BV) | OR1, OR2, OR3, OR5 | TC07_response.* |
| TC08 | 000000000000000000000000 | P3 (BV) | OR1, OR2, OR3, OR4, OR6 | TC08_response.* |
| TC09 | FFFFFFFFFFFFFFFFFFFFFFFF | P3 (BV) | OR1, OR2, OR3, OR4, OR6 | TC09_response.* |
| TC10 | 69855e665c2.6868739f86a6 | P1 | OR1, OR2, OR3, OR5 | TC10_response.* |
| TC11 | 00000 | P2  | OR1, OR2, OR3, OR5 | TC11_response.* |
| TC12 | -1 | P1 | OR1, OR2, OR3, OR5 | TC12_response.* |



