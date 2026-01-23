# Makefile para el Proyecto QA Doctorado

.PHONY: help setup start-gamesshop stop-gamesshop healthcheck smoke Q1-performance Q2-security Q3-integrity Q4-robustness QA-week2 clean

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
	@echo "  Q1-performance      - Escenario Q1: Rendimiento de Endpoints CRUD"
	@echo "  Q2-security         - Escenario Q2: Seguridad de Autenticación y Autorización"
	@echo "  Q3-integrity        - Escenario Q3: Integridad de Persistencia de Datos"
	@echo "  Q4-robustness       - Escenario Q4: Robustez de la API frente a datos inválidos"
	@echo "  QA-week2            - Ejecutar todos los escenarios Q1-Q4 de la semana 2"
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

Q1-performance:
	./scripts/quality_scenario_01.sh

Q2-security:
	./scripts/quality_scenario_02.sh

Q3-integrity:
	./scripts/quality_scenario_03.sh

Q4-robustness:
	./scripts/quality_scenario_04.sh

QA-week2: Q1-performance Q2-security Q3-integrity Q4-robustness
	@echo ""
	@echo "================================"
	@echo "✅ Todos los escenarios Q1-Q4 completados"
	@echo "================================"

clean:
	rm -rf tmp/
	rm -f *.log
