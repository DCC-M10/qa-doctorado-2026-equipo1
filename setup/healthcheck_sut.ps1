Write-Host "Realizando verificación de salud del SUT..."

# Verificar si el contenedor está en ejecución
$container = docker ps --format "{{.Names}}" | Select-String "ts-api-rest-master"

if (-not $container) {
    Write-Host "❌ El contenedor del SUT no está en ejecución"
    Write-Host "➡ Pausando para inspeccionar..."
    Read-Host "Presiona ENTER para continuar"
    exit 1
}

Write-Host "Verificando salud de la API..."

# Chequeo HTTP
$healthUrl = "http://localhost:8000/api/v1/juegos"
$response = curl.exe -s -o $null -w "%{http_code}" $healthUrl

if ($response -eq "200") {
    Write-Host "✅ El SUT está saludable y respondiendo"
    Write-Host "📊 Estado: En ejecución"
    Write-Host "🌐 Endpoint: http://localhost:8000"

    Write-Host "🔍 Recursos del contenedor:"
    docker stats --no-stream ts-api-rest | Select-Object -Skip 1

    Read-Host "Presiona ENTER para cerrar"
    exit 0
} else {
    Write-Host "❌ El SUT no está respondiendo (HTTP $response)"
    Write-Host "🔧 Logs del contenedor:"
    docker logs ts-api-rest --tail 10
    Write-Host "➡ Pausando para inspeccionar..."
    Read-Host "Presiona ENTER para continuar"
    exit 1
}
