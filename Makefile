# Makefile para el Proyecto QA Doctorado 2026
# SUT: ts-api-rest (API REST en TypeScript)

.PHONY: help setup start-sut stop-sut healthcheck smoke test-latency clean

# Objetivo por defecto
help:
	@echo "Objetivos disponibles:"
	@echo "  setup        - Configurar el entorno y preparar scripts"
	@echo "  start-sut    - Iniciar el SUT (ts-api-rest)"
	@echo "  stop-sut     - Detener el SUT"
	@echo "  healthcheck  - Verificar la salud del SUT"
	@echo "  smoke        - Ejecutar pruebas de humo"
	@echo "  test-latency - Medir latencia del SUT"
	@echo "  clean        - Limpiar archivos temporales y logs"

# Configuración inicial del entorno
setup:
	@echo "Configurando entorno..."
	chmod +x setup/*.sh scripts/*.sh
	./setup/run_sut.sh

# Iniciar el SUT
start-sut:
	@echo "Iniciando SUT ts-api-rest..."
	./setup/run_sut.sh

# Detener el SUT
stop-sut:
	@echo "Deteniendo SUT ts-api-rest..."
	./setup/stop_sut.sh

# Verificar la salud del SUT
healthcheck:
	@echo "Ejecutando healthcheck del SUT..."
	./setup/healthcheck_sut.sh

# Limpieza de archivos temporales
clean:
	@echo "Limpiando archivos temporales..."
	rm -rf tmp/
	rm -f *.log
