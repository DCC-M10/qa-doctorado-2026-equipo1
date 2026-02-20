# Semana 6 - Gaming Drill del Quality Gate (Goodhart) + Endurecimiento

**Proyecto: Games Shop**

## Táctica de gaming elegida

**Táctica:**\

"Debilitar la evidencia sin declararlo" mediante la modificación del
script que ejecuta los casos de prueba (por ejemplo
`scripts/systematic_cases.sh`) para que genere resultados "PASS" sin
ejecutar realmente los casos del sistema Games Shop.

**Por qué es plausible en Games Shop:**\
Si el quality gate solo verifica que existe
n archivos de evidencia
(logs, reportes o salidas), pero no valida su integridad o contenido
real, es posible reemplazar el script por uno que simplemente imprima
resultados exitosos sin ejecutar pruebas reales sobre funcionalidades
como:

-   registro de usuarios\
-   gestión de productos\

En ese escenario, el gate podría mostrarse "verde" aunque el sistema
tenga fallos reales.

------------------------------------------------------------------------

## Qué demuestra este drill

### Before (sin verificación de integridad):

El script modificado genera salidas "PASS" simuladas.\
El quality gate acepta la evidencia porque solo valida existencia de
archivos, no su autenticidad ni ejecución real.\

**Resultado:** señal engañosa de calidad.

### After (con verificación de integridad):

Se implementa una validación de integridad (por ejemplo, verificación de
hash o comparación con baseline registrado).\
Cuando se intenta el mismo bypass, el gate detecta que el script fue
alterado y falla explícitamente.\

**Resultado:** el intento de gaming queda bloqueado.

------------------------------------------------------------------------

## Cómo ejecutar (local)

1.  Asegurarse de tener Docker y make instalados.\
2.  Cambiar a la rama `week6`.\
3.  Ejecutar:

    - `make gaming-drill`

4.  Revisar evidencia generada en:

    - `evidence/week6/before/`
    - `evidence/week6/after/`
    - `evidence/week6/summary.txt`

El archivo `summary.txt` mostrará el resultado comparativo del
experimento BEFORE y AFTER.

------------------------------------------------------------------------

## Artefactos protegidos por integridad (baseline)

En el proyecto Games Shop, los siguientes elementos se consideran
críticos para la validez del gate:

-   `scripts/systematic_cases.sh`
-   `design/oracle_rules.md`
-   `design/test_cases.md`

Si alguno de estos archivos se modifica intencionalmente como parte de
una mejora legítima, se debe:

1.  Actualizar `ci/gate_integrity_baseline.txt`
2.  Registrar el cambio en `ci/gate_change_log.md` indicando:
    -   fecha
    -   motivo del cambio
    -   impacto esperado

------------------------------------------------------------------------
