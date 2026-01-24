# Memo de Progreso - Semana 1

**Fecha**: 17/01/2026  \
**Equipo**: Equipo 1  \
**Semana**: 1 de 8

## Objetivos de la semana
- Seleccionar y documentar el SUT.
- Preparar scripts básicos para levantar, verificar y detener el SUT.
- Publicar instrucciones mínimas de uso en el README y facilitar su ejecución con Makefile.
- Registrar acuerdos de colaboración del equipo.

## Logros
- SUT seleccionado: Games Shop (ts-api-rest) y documentado en SUT_SELECTION.md, justificando su elección como sistema con autenticación JWT y endpoints CRUD protegidos.
- Scripts de entorno creados en setup/:
  - run_sut.sh para el arranque del SUT en contenedor Docker.
  - healthcheck_sut.sh para validar la disponibilidad del API mediante una solicitud HTTP básica.
  - stop_sut.sh para la detención controlada del contenedor.
- Makefile añadido para orquestar setup, arranque, detención y verificación del SUT.
- README actualizado, incluyendo la estructura del repositorio, prerrequisitos (Docker) y pasos mínimos para ejecutar el proyecto.
- Acuerdos iniciales del equipo documentados en AGREEMENTS.md, estableciendo normas de colaboración y responsabilidades.

## Evidencia principal
- Selección y motivación del SUT: SUT_SELECTION.md.
- Ejecución y control del SUT: setup/run_sut.sh, setup/healthcheck_sut.sh, setup/stop_sut.sh.
- Operaciones unificadas: Makefile.
- Instrucciones de uso y estructura: README.md.
- Normas de colaboración: AGREEMENTS.md.

## Retos y notas
- Dependencia de Docker: el entorno de ejecución requiere Docker instalado y operativo; este requisito se encuentra documentado en el README.
- Gestión de permisos de ejecución: se emplea chmod dentro de la tarea setup del Makefile para evitar errores al invocar los scripts en distintos sistemas operativos.
- Exposición del servicio: el contenedor del SUT expone el API en http://localhost:8000, utilizado como punto base para el healthcheck y futuras pruebas funcionales.
- Seguridad mediante JWT: varios endpoints del SUT requieren autenticación, lo que introduce consideraciones adicionales para las pruebas de acceso y autorización.

## Lecciones aprendidas
- Centralizar los comandos en un Makefile reduce la complejidad del entorno y minimiza errores manuales durante la ejecución del SUT.
- Implementar un healthcheck temprano permite detectar rápidamente fallos de despliegue antes de ejecutar pruebas más complejas.
- Seleccionar un SUT con autenticación JWT aporta un contexto realista para el análisis de calidad, incorporando pruebas funcionales y de seguridad.
- Mantener la documentación concisa y bien localizada (README + SUT_SELECTION) facilita la incorporación de nuevos integrantes al proyecto.

## Próximos pasos (Semana 2) - (Potenciales pasos, a ser discutidos con el equipo)
- Elaborar casos de prueba funcionales y reglas de oráculo para los principales endpoints del Games Shop (design/test_cases.md y design/oracle_rules.md).
- Extender los scripts de prueba, incluyendo smoke tests y pruebas sistemáticas (smoke y systematic_cases) para endpoints críticos del API.
- Definir métricas básicas de calidad (disponibilidad, tiempo de respuesta, manejo de errores) y registrar evidencias en evidence/week2/.
- Refinar la estrategia de riesgos y pruebas en risk/test_strategy.md, considerando autenticación JWT y control de acceso.


---

**Preparado por**: Equipo 1  \
**Próxima revisión**: Semana 2
