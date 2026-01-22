# Escenarios de Calidad

## Descripción General

Este documento define los escenarios de calidad utilizados para evaluar la aplicación Games Shop. Los escenarios de calidad ayudan a establecer criterios medibles para los requisitos no funcionales.

# Semana 2 — Escenarios de calidad (falsables y medibles)

Referencia de formato:
- Un escenario debe tener: Estímulo, Entorno, Respuesta, Medida, Evidencia.

## Escenario Q1 — Seguridad de Autenticación y Autorización
- Estímulo: Acceso sin token a rutas con protección (POST /api/v1/juegos, DELETE /api/v1/files/:id). Acceso con token incorrecto o expirado. Acceso con token válido pero rol insuficiente (si aplica).
- Entorno: ejecución local, SUT recién iniciado
- Respuesta: el SUT entrega el documento OpenAPI
- Medida (falsable): HTTP 200 y el cuerpo contiene el campo "openapi"
- Evidencia: evidence/week2/openapi.json (captura) y openapi_http_code.txt

## Escenario Q2 — Integridad de Persistencia de Datos
- Estímulo: Secuencia de operaciones: crear un juego → modificarlo → eliminarlo. Verificaciones posteriores de lectura.
- Entorno: API en entorno de pruebas con almacenamiento MongoDB activo.
- Respuesta: Después de cada operación, el recurso debe reflejar el estado esperado. Los datos eliminados no deben encontrarse mediante consultas posteriores.
- Medida (falsable):Resultados de las consultas GET /juegos/:id después de cada operación: Después de creación → existe y coincide con los datos enviados. Después de modificación → coincide con los cambios.Después de eliminación → no existe (404).
- Evidencia: evidence/week2/latency.csv y evidence/week2/latency_summary.txt

## Escenario Q3 — Robustez ante IDs inválidos en /pet/{id} (Robustness / Error Handling)
- Estímulo: se solicita GET /pet/{id} con valores inválidos (e.g., -1, 0, 999999, abc)
- Entorno: ejecución local, sin carga, 1 vez por caso
- Respuesta: el SUT NO debe responder 200 para entradas inválidas
- Medida (falsable): para cada caso, HTTP != 200 (se registra el código)
- Evidencia: evidence/week2/invalid_ids.csv + evidence/week2/pet_<id>.json

## Escenario Q4 — Respuesta “bien formada” en inventario (Data Shape Sanity)
- Estímulo: se solicita GET /store/inventory
- Entorno: ejecución local, sin carga, 1 vez
- Respuesta: el cuerpo es JSON (no HTML / texto inesperado)
- Medida (falsable): el cuerpo comienza con '{' y el request devuelve HTTP 200
- Evidencia: evidence/week2/inventory.json y inventory_http_code.txt


## Criterios de Éxito

Cada escenario incluye criterios de éxito específicos y medibles que serán evaluados durante las fases de prueba. Los resultados serán documentados en las carpetas de evidencia para cada semana de pruebas.