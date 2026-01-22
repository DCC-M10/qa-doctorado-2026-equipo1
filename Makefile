# Makefile para el Proyecto QA Doctorado

.PHONY: help setup start-gamesshop stop-gamesshop healthcheck smoke Q1-contract Q2-latency Q3-invalid-inputs Q4-inventory QA-week2 clean

# Objetivo por defecto
help:
	@echo "Objetivos disponibles:"
	@echo ""
	@echo "Configuración:"
	@echo "  setup          - Configurar el entorno"
	@echo "  start-gamesshop - Iniciar la aplicación Games Shop"
	@echo "  stop-gamesshop  - Detener la aplicación Games Shop"
	@echo "  healthcheck    - Verificar la salud del sistema"
	@echo ""
	@echo "Escenarios de Calidad - Semana 2:"
	@echo "  Q1-contract        - Escenario Q1: Disponibilidad mínima del contrato OpenAPI"
	@echo "  Q2-latency         - Escenario Q2: Latencia básica del endpoint de inventario"
	@echo "  Q3-invalid-inputs  - Escenario Q3: Robustez ante IDs inválidos"
	@echo "  Q4-inventory       - Escenario Q4: Respuesta bien formada en inventario"
	@echo "  QA-week2           - Ejecutar todos los escenarios Q1-Q4 de la semana 2"
	@echo ""
	@echo "Pruebas Legacy:"
	@echo "  smoke          - Ejecutar pruebas de humo"
	@echo ""
	@echo "Utilidades:"
	@echo "  clean          - Limpiar archivos temporales"

setup:
	@echo "Configurando entorno..."
	chmod +x setup/*.sh scripts/*.sh
	./setup/run_sut.sh

start-gamesshop:
	./setup/run_sut.sh

stop-gamesshop:
	./setup/stop_sut.sh

healthcheck:
	./setup/healthcheck_sut.sh

smoke:
	./scripts/smoke.sh

Q1-contract:
	./scripts/quality_scenario_01.sh

Q2-latency:
	./scripts/quality_scenario_02.sh

Q3-invalid-inputs:
	./scripts/quality_scenario_03.sh

Q4-inventory:
	./scripts/quality_scenario_04.sh

QA-week2: Q1-contract Q2-latency Q3-invalid-inputs Q4-inventory
	@echo ""
	@echo "================================"
	@echo "✅ Todos los escenarios Q1-Q4 completados"
	@echo "================================"

clean:
	rm -rf tmp/
	rm -f *.log
