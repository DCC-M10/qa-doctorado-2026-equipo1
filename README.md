# QA Doctorado 2026 - Equipo 1

## Descripción del Proyecto

Este repositorio contiene el trabajo y la documentación desarrollados por el Equipo 1 para la asignatura de Pruebas y Calidad del Software del Doctorado.

El proyecto se basa en la evaluación de calidad y pruebas del System Under Testing (SUT) seleccionado: ts-api-rest, una API REST desarrollada en TypeScript, ejecutable localmente y diseñada para ser observable, reproducible y adecuada para la medición de calidad del software.

A lo largo del proyecto se aplican prácticas de aseguramiento de la calidad (QA) que incluyen planificación de pruebas, diseño de casos, ejecución, recolección de evidencias y análisis de resultados.

## Estructura del Repositorio
La estructura del repositorio está organizada para soportar el proceso completo de QA y facilitar la trazabilidad entre pruebas, evidencias y documentación:

- `setup/` - Scripts de configuración del entorno

## Primeros Pasos
Antes de comenzar, se recomienda revisar el documento de acuerdos del equipo, donde se establecen las normas de trabajo, estándares de calidad y mecanismos de resolución de conflictos: [Agreements](./AGREEMENTS.md)

## Instalación docker
El proyecto requiere un entorno con Docker instalado para garantizar la ejecución reproducible del SUT.

Consulte la documentación oficial de Docker para su sistema operativo: [Obtener Docker](https://docs.docker.com/get-docker/)

## Instrucciones de ejecución del proyecto
### Opción 1: Uso de make

Si su entorno cuenta con la herramienta make, puede ejecutar el siguiente comando para ver la lista de comandos disponibles: "make"

Desde allí podrá iniciar, detener y verificar la salud del SUT de forma automatizada.

### Opción 2: Ejecución manual

Si su sistema operativo no dispone de make, puede ejecutar directamente los scripts ubicados en el directorio: "setup/"

Se recomienda ejecutarlos en el orden que resulte conveniente según el entorno, siguiendo la lógica de:
  - inicio del SUT
  - verificación de estado
  - detención del SUT

## Miembros del Equipo

- Jorge Mostajo
- Edgar Jaldín Torrico
- May Dunnia Lopez Negrete
- Julio César Becerra Lino

### Quality Gate (CI)

- CI:
   - **Workflow:** .github/workflows/ci.yml
   - **Artifact:** week5-evidence


