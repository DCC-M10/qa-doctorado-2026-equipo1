# Memo de Progreso - Semana 5

**Fecha**: 16/02/2026  \
**Equipo**: Equipo 1  \
**Semana**: 5 de 8



**Proyecto:** Games Shop  
**Tema:** Quality Gate en Continuous Integration (CI)

---

## 1. Objetivos de la Semana

- Definir un **Quality Gate formal y trazable** alineado a los riesgos priorizados en la Semana 3.
- Implementar un gate ejecutable de forma automática tanto **localmente** como en **CI (GitHub Actions)**.
- Conectar explícitamente:

  ```
  Riesgo → Escenario → Oráculo → Evidencia → Decisión binaria
  ```

- Reducir la incertidumbre sobre atributos críticos: **disponibilidad, robustez y control de acceso**.

---

## 2. Logros Alcanzados

### 2.1 Quality Gate definido formalmente

Se documentó el archivo:

```
ci/quality_gates.md
```

Estableciendo:

- Objetivo del gate
- 3 checks alineados a riesgos Top 3
- Oráculos explícitos (OR1–OR5)
- Evidencia requerida
- Trazabilidad a artefactos de Semana 3 y Semana 4
- Criterios de alta señal / bajo ruido

---

### 2.2 Gate ejecutable local y en CI

Se implementó:

- Script:
  ```
  run_quality_gate.sh
  ```
- Workflow GitHub Actions:
  ```
  .github/workflows/ci.yml
  ```
- Comando local:

```bash
make quality-gate
```

El gate:

- Levanta el entorno Docker
- Ejecuta los 3 checks
- Genera evidencia
- Bloquea la integración si algún oráculo falla (`exit 1`)

---

### 2.3 Evidencia Week 5 generada 

Se generan automáticamente archivos en:

```
evidence/week5/
```

Incluyendo:

- `availability_http_code.txt`
- `availability_body.json`
- `invalid_ids_results.csv`
- `valid_ids_results.csv`
- `security_results.csv`
- `security_summary.txt`

La evidencia es:

- Reproducible
- Determinista
- Trazable
- Binaria (pass/fail)



---

### 2.4 Relación explícita con riesgos (Semana 3) y oráculos/casos (Semana 4)

El Quality Gate conecta directamente con:

#### Semana 3 — Riesgos Prioritarios

- **R1:** Acceso no autorizado a endpoints protegidos
- **R2:** Error 500 con inputs válidos
- **R3:** Endpoint principal no responde

#### Semana 4 — Diseño sistemático y oráculos

- **OR1:** Registro
- **OR2:** No HTML
- **OR3:** ID inválido no aceptado
- **OR4:** Comportamiento permitido para ID válido
- **OR5:** No 5xx
- Casos sistemáticos definidos en:

```
design/test_cases.md
```

Se mantiene coherencia metodológica entre:

```
Riesgo → Diseño → Oráculo → Evidencia → Gate automático
```

---

## 3. Evidencia Principal

- `ci/quality_gates.md`
- `run_quality_gate.sh`
- `.github/workflows/ci.yml`
- Carpeta `evidence/week5/`
- Ejecución exitosa en entorno local
- Ejecución automática en GitHub Actions

---

## 4. Retos / Notas

- Asegurar que el entorno Docker arranque correctamente en CI.
- Evitar métricas inestables (ej. latencia) como criterio de bloqueo.
- Mantener determinismo en los IDs utilizados.
- Gestionar correctamente el estado del SUT para evitar falsos positivos.

---

## 5. Lecciones Aprendidas

- Un Quality Gate efectivo debe ser simple, determinista y trazable.
- Los oráculos explícitos reducen ambigüedad y subjetividad.
- No todo debe bloquear el CI: métricas variables deben registrarse, no bloquear.
- La trazabilidad entre semanas fortalece la validez metodológica.
- El valor real del CI no es ejecutar pruebas, sino prevenir regresiones críticas.

---

## 6. Próximos Pasos

- Agregar publicación automática de artifacts en GitHub Actions.
- Incorporar repetición controlada para detectar inestabilidad.
- Ampliar cobertura hacia otros atributos (ej. manejo de errores global).
- Evaluar integración con métricas informativas (sin bloqueo).
- Consolidar documentación final para entrega del módulo.

---

**Preparado por**: Equipo 1  \
**Próxima revisión**: Semana 6
