
# DEFENSA ANTI-GAMING (Semana 6): Auditoría de Integridad Check 2

# 1. Definir el contrato inmutable (ej. 4 particiones de equivalencia diseñadas)
EXPECTED_EQ_CASES=4
CSV_FILE="evidence/week5/invalid_ids_results.csv"

# 2. Verificar que el archivo de evidencia existe
if [ ! -f "$CSV_FILE" ]; then
    echo "  -> FAIL (Integridad): Archivo de evidencia no encontrado ($CSV_FILE)."
    exit 1
fi

# 3. Contar los casos reales ejecutados (Total de líneas menos 1 de la cabecera)
ACTUAL_CASES=$(($(wc -l < "$CSV_FILE") - 1))

# 4. Oráculo de Proceso: Comparación matemática estricta
if [ "$ACTUAL_CASES" -ne "$EXPECTED_EQ_CASES" ]; then
    echo "  -> FAIL (Integridad): Violación del contrato de pruebas."
    echo "     Esperados: $EXPECTED_EQ_CASES casos."
    echo "     Ejecutados: $ACTUAL_CASES casos."
    echo "     Posible intento de gaming por reducción silenciosa de cobertura."
    exit 1
else
    echo "  -> PASS (Integridad): Volumen de evidencia coincide con el diseño ($ACTUAL_CASES/$EXPECTED_EQ_CASES)."
fi

