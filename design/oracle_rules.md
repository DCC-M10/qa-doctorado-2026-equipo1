# Reglas de Oráculo — Semana 4 (Games Shop)

**Objeto de prueba:** `GET /api/v1/juegos/{id}`

Estas reglas definen criterios **pass/fail** para evaluar casos sistemáticos.  
Se distinguen reglas **mínimas** (seguras, poco asumidas), reglas de **partición** (EQ) y reglas **estrictas** (cuando aplique).

## Reglas mínimas (aplican a todos los casos)

- **OR1 (Registro):** cada ejecución debe registrar `http_code` y guardar el cuerpo de respuesta como evidencia.
- **OR2 (No HTML):** la respuesta **no** debe ser HTML (si el primer carácter no vacío es `<`, se considera fallo del oráculo).

## Reglas por partición (EQ)

- **OR3 (ID inválido no aceptado):** si `{id}` contiene caracteres que no existen en {0-9;A-F;a-f}, entonces `http_code != 200`.
- **OR4 (ID válido aceptado — comportamiento permitido):** si `{id}` existe en {0-9;A-F;a-f} con longitud = 24, entonces `http_code` debe estar en `{200, 404}`.

## Reglas estrictas (opcional / reportar como “estrictas”)

- **OR5 (No 5xx):** la respuesta no debe retornar **5xx**. (5xx implica fallo del servicio ante la solicitud).
- **OR6 (Consistencia semántica cuando hay 200):** si `http_code == 200` para `{id}` numérico, el cuerpo debería incluir un campo `"id"` (idealmente con el mismo valor).

  > Nota: se reporta como chequeo estricto porque depende de datos/estado del SUT.
