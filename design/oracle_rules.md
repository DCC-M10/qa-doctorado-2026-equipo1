# Reglas de Oráculo — Semana 4 (Games Shop)

**Objeto de prueba:** `POST /api/v1/juegos`

Estas reglas definen criterios **pass/fail** para evaluar casos sistemáticos sobre el endpoint seleccionado.  
Se distinguen **reglas mínimas** (seguras, poco asumidas), **por partición** (EQ) y **reglas estrictas** (cuando aplique).

---

## Reglas mínimas (aplican a todos los casos)

- **OR1 (Registro de evidencia)**
  
    Cada ejecución del endpoint debe registrar el http_code y almacenar el cuerpo completo de la respuesta como evidencia.

  **Pass:** código HTTP y body quedan registrados.
 
  **Fail:** falta el código HTTP o no se guarda la respuesta.
  
- **OR2 (Formato de respuesta – no HTML)**
  
  La respuesta del servicio no debe ser HTML. Si el primer carácter no vacío del body es <, se considera un fallo.

   **Pass:** la respuesta es JSON u otro formato esperado por la API.
 
   **Fail:** la respuesta corresponde a HTML (error de backend o gateway).
  
- **OR3 (No error de servidor)**
  
  La respuesta no debe retornar códigos HTTP de la familia 5xx.

   **Pass:** http_code ∉ {500–599}.
 
   **Fail:** cualquier código 5xx, lo que indica un fallo del servicio ante la solicitud.
  
- **OR4 (Solicitud inválida no aceptada)**
  
  Si el body contiene campos obligatorios ausentes, vacíos o con tipo incorrecto, el endpoint no debe responder con 201 ni 200.

   **Pass:** http_code ∈ {400, 422}.
 
   **Fail:** http_code ∈ {200, 201} ante datos inválidos.

---

## Reglas por partición (EQ) y valores límite (BV)

- **OR5 (Solicitud válida – creación permitida):**
  
  Si el body incluye todos los campos obligatorios con valores válidos, el endpoint debe indicar creación exitosa.

   **Pass:** http_code == 201 (o 200 si así está definido en el SUT).
 
   **Fail:** cualquier otro código HTTP ante una solicitud válida.

---

## Reglas estrictas (opcional / reportar como “estrictas”)

- **OR6 (Consistencia semántica en creación exitosa)**
  
  Si http_code == 201, el cuerpo de la respuesta debería incluir un identificador único del juego creado (por ejemplo, id).

   **Pass:** el body contiene el campo id.
 
   **Fail:** no se devuelve identificador tras creación exitosa.
 
- **OR7 (Persistencia observable del recurso creado)**
  
  Si un juego es creado exitosamente (201), una consulta posterior al recurso (por su id) debería permitir recuperar la información registrada.

   **Pass:** el recurso puede ser recuperado correctamente.
 
   **Fail:** el recurso no existe o los datos no coinciden.

