# Reporte Semana 4 — Diseño sistemático de pruebas y oráculos (Games Shop)

## 1) Objeto de prueba elegido y motivación

**Objeto de prueba (Endpoint):** 

POST /api/v1/juegos.

**Motivación:** 

El endpoint permite crear un recurso juego a partir de un cuerpo JSON con múltiples campos obligatorios y restricciones de dominio (tipos, rangos y valores permitidos). Esta combinación de entradas estructuradas lo convierte en un buen candidato para aplicar diseño sistemático, ya que pequeñas variaciones en los datos de entrada pueden generar comportamientos distintos (éxito, error de validación o falla del servidor), lo que permite evaluar la robustez del manejo de entradas sin depender del estado interno del sistema.

## 2) Técnica de diseño utilizada y justificación

**Técnica elegida:** 

Equivalencia de Clases (EQ) + Valores Límite (BV).

**Justificación:**

Se aplicó EQ para particionar sistemáticamente el dominio de entrada del cuerpo JSON en clases relevantes (payload válido, campos obligatorios ausentes, tipos inválidos, valores fuera de rango). Complementariamente, se utilizó BV para ejercitar valores cercanos a los límites definidos por el contrato del endpoint (por ejemplo, valores mínimos, máximos y extremos para campos numéricos o longitudes de texto).

Esta elección es metodológicamente adecuada porque:

- Permite derivar casos de prueba defendibles y no ad-hoc.

- Es trazable desde el contrato del endpoint hacia los casos ejecutados.

- Reduce el riesgo de combinaciones explosivas que no aportan evidencia adicional relevante en esta etapa.
  
No se utilizó combinatoria/pairwise ni combinación de técnicas, ya que el objetivo del ejercicio es evaluar robustez del manejo de entradas individuales, no interacciones complejas entre múltiples factores.


## 3) Oráculos (mínimos vs estrictos)

Las reglas de oráculo están definidas en design/oracle_rules.md y se aplican automáticamente durante la ejecución.

- **Oráculos mínimos (defendibles sin suponer datos):**
  
     - La respuesta no debe ser HTML (evita respuestas inesperadas del framework).

     - El servidor no debe responder con códigos 5xx ante solicitudes controladas.

     - Payloads inválidos (campos faltantes, tipos incorrectos, valores fuera de dominio) no deben retornar 201/200.

     - Payloads válidos deben retornar un código de éxito esperado (201 o 200, según contrato).

- **Oráculo estricto (opcional):**
  
     - Si la respuesta es exitosa, el cuerpo debe incluir un identificador del recurso creado (por ejemplo, id) y cumplir la estructura JSON esperada.

El oráculo mínimo permite decisiones pass/fail reproducibles sin depender de datos persistidos ni reglas de negocio internas.


## 4) Cobertura afirmada (y lo que NO se afirma)
**Se afirma:**

- Cobertura sistemática de clases de entrada relevantes del endpoint POST /api/v1/juegos mediante EQ.

- Ejercicio de valores límite críticos definidos por el contrato del API.

- Evidencia reproducible por caso (request, response, código HTTP y decisión pass/fail).

- Evaluación de la robustez del endpoint frente a entradas válidas e inválidas.

    
**No se afirma:**

- Correctitud funcional completa del dominio “juegos”.

- Persistencia real o consistencia de datos en la base de datos.

- Cumplimiento de reglas de negocio complejas.

- Seguridad, concurrencia, rendimiento o comportamiento bajo carga.

- Estabilidad temporal del sistema en diferentes ejecuciones prolongadas.


## 5) Amenazas a la validez (interno/constructo/externo)
- **Interna:**
 
El estado del SUT (por ejemplo, validaciones internas o configuraciones del entorno) puede afectar el código de respuesta ante ciertos payloads.

*Mitigación:* Uso de oráculos mínimos que no dependen del contenido persistido ni de reglas de negocio no observables.

- **Constructo:**
  
El uso de códigos HTTP y estructura de respuesta como proxy de “calidad” evalúa principalmente robustez y manejo de errores, no calidad funcional total.

*Mitigación:* Declarar explícitamente que el atributo evaluado es manejo de entradas y estabilidad de respuesta.

- **Externa:**
  
Los resultados pueden variar según el entorno de ejecución (local, Docker, versión del backend).

*Mitigación:* ejecución reproducible mediante script versionado y registro explícito del entorno en la evidencia.

## 6) Evidencia

- **Casos de prueba:** design/test_cases.md
- **Oráculos:** design/oracle_rules.md
- **Ejecución reproducible:** scripts/systematic_cases.sh
- **Evidencia por caso y resumen:** evidence/week4/
  
  - respuestas por TC
  
  - results.csv
  
  - summary.txt
  
  
