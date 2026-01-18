# SUT_SELECTION.md — Games Shop

## SUT elegido
- Nombre: Ts-Api-Rest
- Tipo: API REST (OpenAPI)
- Fuente: [https://github.com/ts-api-rest](https://github.com/joseluisgs/ts-api-rest)

## Motivo de selección
- Es un SUT estándar, público y reproducible (ideal para probar y comparar resultados entre equipos).
- Permite ejecutar localmente con Docker y observar comportamiento vía HTTP.
- Tiene especificación OpenAPI para derivar pruebas y oráculos básicos.

### 1. Fácil ejecución local y reproducible

El proyecto puede ejecutarse de manera local sin dependencias complejas, y además proporciona configuración compatible con Docker / Docker Compose. Esto permite que cualquier miembro del equipo pueda levantar el servicio en su propio entorno de manera consistente.
Este requisito es fundamental para cumplir con las directrices de la tarea y asegurar la repetibilidad de pruebas.

### 2. Interfaz observable a través de API HTTP

La aplicación expone una API REST completa con múltiples endpoints, lo que facilita la creación de pruebas automatizadas, pruebas funcionales y de integración.
Contar con una interfaz HTTP claramente definida permite observar el comportamiento del sistema, verificar respuestas, medir latencia y validar esquemas y reglas de negocio a través de herramientas como curl, Postman o frameworks de pruebas (Jest + Supertest).

### 3. Adecuado para pruebas automatizadas

El repositorio está desarrollado en TypeScript, un lenguaje que promueve claridad y tipado fuerte, lo que facilita el diseño de casos de prueba automatizados.
Además, el proyecto está estructurado de forma modular y con documentación mínima, lo que ayuda a generar pruebas unitarias y de integración, así como a medir cobertura y calidad de código.

### 4. No depende de datos sensibles

El proyecto no requiere credenciales privadas, claves de acceso o bases de datos externas cerradas para su ejecución.
Esto cumple con la condición académica de utilizar un SUT que no dependa de información sensible o inaccesible, permitiendo que los miembros del equipo y cualquier evaluador puedan reproducir las pruebas libremente.

### 5. Permite escenarios variados de pruebas

El diseño del proyecto incluye múltiples rutas y operaciones (CRUD), autenticación y gestión de archivos, lo que posibilita la creación de diferentes tipos de pruebas: funcionales, de seguridad básica, de integración y de rendimiento.
Esto enriquece el análisis de calidad y permite explorar más dimensiones dentro del marco de QA.

