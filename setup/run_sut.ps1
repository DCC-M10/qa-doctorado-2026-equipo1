# setup/run_sut.ps1
$ErrorActionPreference = "Stop"

# Ruta relativa al proyecto SUT (ajusta si es necesario)
$SutPath = "..\ts-api-rest\ts-api-rest-master"

Write-Host "Arrancando SUT desde $SutPath ..."

if (-not (Test-Path $SutPath)) {
    Write-Host "❌ No se encontró la ruta del SUT: $SutPath"
    Read-Host "Presiona ENTER para cerrar"
    exit 1
}

$originalPath = Get-Location
Set-Location $SutPath

try {
    Write-Host "Ejecutando: docker compose up -d"
    docker compose up -d
    Write-Host "✅ SUT iniciado (docker compose up -d)"

    Write-Host "Esperando unos segundos para que la API levante..."
    Start-Sleep -Seconds 5
}
catch {
    Write-Host "⚠ Error al arrancar el SUT"
    Write-Host $_.Exception.Message
}
finally {
    Set-Location $originalPath
    Read-Host "Presiona ENTER para cerrar"
}

