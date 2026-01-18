# setup/stop_sut.ps1
$ErrorActionPreference = "Stop"

$SutPath = "..\ts-api-rest\ts-api-rest-master"

Write-Host "Deteniendo SUT en $SutPath ..."

if (-not (Test-Path $SutPath)) {
    Write-Host "❌ No se encontró la ruta del SUT: $SutPath"
    Read-Host "Presiona ENTER para cerrar"
    exit 1
}

$originalPath = Get-Location
Set-Location $SutPath

try {
    Write-Host "Ejecutando: docker compose down"
    docker compose down
    Write-Host "✅ SUT detenido (docker compose down)"
}
catch {
    Write-Host "⚠ Error al detener el SUT"
    Write-Host $_.Exception.Message
}
finally {
    Set-Location $originalPath
    Read-Host "Presiona ENTER para cerrar"
}
