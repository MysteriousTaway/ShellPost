# Load config
$configJson = Get-Content "data/manifest.json"
# Convert to object
$configObject = $configJson |ConvertFrom-Json

$configContext = $configObject | Select-Object -ExpandProperty "Context"
$configPage = $configObject | Select-Object -ExpandProperty "Page"
$configPageSingle = $configObject | Select-Object -ExpandProperty "Page:Single"

Write-Host "object>>> " $configObject -BackgroundColor Blue
Write-Host "context>>> " $configObject.Context -BackgroundColor Yellow
Write-Host "page>>> " $configObject.Page -BackgroundColor Blue
Write-Host "single>>> " $configObject.Page.Single -BackgroundColor Yellow
Write-Host "single.upload>>> " $configObject.Page.Single.Upload -BackgroundColor Yellow
Write-Host "multi.main>>> " $configObject.Page.Multi.Main -BackgroundColor Yellow