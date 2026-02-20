# Memo de Progreso - Semana 6

**Fecha:** 19/02/2026\
**Equipo:** Equipo 1 - Games Shop\
**Semana:** 6 de 8

## Objetivos de la semana

-   Identificar un riesgo real de gaming (Goodhart) aplicable al quality
    gate del proyecto Games Shop.
-   Demostrar el bypass con evidencia reproducible (before).
-   Implementar una defensa técnica mínima basada en verificación de
    integridad y validarla (after).
-   Registrar reglas mínimas de gobernanza del gate (change log +
    baseline auditable).


## Logros

-   Se implementó un gaming drill reproducible que demuestra cómo el
    quality gate podía mostrarse "PASS" sin ejecutar realmente los casos
    del sistema Games Shop.
-   Se simuló el reemplazo del script de ejecución de pruebas
    (`systematic_cases.sh`) para generar resultados falsamente exitosos.
-   Se incorporó una verificación de integridad basada en comparación
    contra un baseline registrado, permitiendo detectar modificaciones
    no autorizadas en artefactos críticos.
-   Se documentó el cambio en `ci/gate_change_log.md` y se estableció un
    baseline auditable en `ci/gate_integrity_baseline.txt`.


## Evidencia principal

-   Drill reproducible: `ci/run_gate_gaming_drill.sh`,
    `ci/gaming_drill.md`
-   Defensa aplicada: verificación de integridad contra baseline
    registrado
-   Evidencia de ejecución: `evidence/week6/` (carpetas before/ y after/
    con salidas comparables)


## Retos y notas

-   La verificación por integridad requiere actualizar explícitamente el
    baseline cuando existan cambios legítimos en los scripts o
    artefactos protegidos.
-   El objetivo del drill no es promover malas prácticas, sino demostrar
    de forma controlada cómo un gate puede ser vulnerable si no tiene
    controles mínimos.


## Lecciones aprendidas

-   Un quality gate puede ser "optimizado" o manipulado si se convierte
    en un objetivo numérico en lugar de un mecanismo de evidencia real
    (Goodhart).
-   La verificación de integridad y el registro formal de cambios
    fortalecen la confiabilidad y trazabilidad del gate.
-   Un control técnico simple puede transformar un indicador frágil en
    un instrumento más auditable y defendible.

## Próximos pasos (Semana 7)

-   Revisar el gate para alinearlo aún más con riesgos reales del
    sistema Games Shop (sin aumentar ruido innecesario).
-   Preparar insumos para IA en control de calidad.



**Preparado por:** Equipo 1 -- Games Shop
