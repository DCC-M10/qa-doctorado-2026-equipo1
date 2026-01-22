# Escenarios de Calidad

## Descripción General

Este documento define los escenarios de calidad utilizados para evaluar la aplicación Games Shop. Los escenarios de calidad ayudan a establecer criterios medibles para los requisitos no funcionales.

# Semana 2 — Escenarios de calidad (falsables y medibles)

Referencia de formato:
- Un escenario debe tener: Estímulo, Entorno, Respuesta, Medida, Evidencia.

## Escenario Q1 — Rendimiento de Endpoints CRUD
### Estímulo  
Se simulan **30 peticiones concurrentes** de:
- Lectura: `GET /api/v1/juegos`
contra la API.

### Entorno
API desplegada en entorno de pruebas con:
- Base de datos **MongoDB** activa  
- Configuraciones estándar (dev/prod)  
- Testing ejecutado desde una máquina de pruebas

### Respuesta
La API debe procesar las solicitudes **sin fallos de error 5xx**.

### Medida  
- Tiempo medio de respuesta por tipo de operación  
- Porcentaje de errores  

### Criterios de aceptación
- **Lecturas:** tiempo medio ≤ **500 ms**  
- **Tasa de éxito:** ≥ **99 %** para todas las peticiones  

### Evidencia
- Ruta: evidence/week2/performance_results.csv y evidence/week2/performance_summary.txt

## Escenario Q2 — Seguridad de Autenticación y Autorización
### Estímulo
- Acceso sin token a rutas con protección:
  - `POST /api/v1/juegos`
- Acceso con token incorrecto o expirado.
- Acceso con token válido y con rol suficiente (si aplica).

### Entorno
API en entorno de pruebas con **JWT** configurado y políticas de autorización activas.

### Respuesta
La API debe rechazar accesos no autorizados y permitir accesos válidos.

### Medida
- Las solicitudes **no autenticadas** o **no autorizadas** retornan **401** o **403**, según corresponda.
- Las solicitudes con **JWT válido** retornan **200** o **201** en las acciones permitidas.

### Evidencia
- Capturas de respuestas HTTP con códigos de estado.
- Evidencia: evidence/week2/security_results.csv y evidence/week2/security_results.txt

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