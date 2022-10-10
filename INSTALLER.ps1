# Installs required components automatically
# Update all already downloaded:
Write-Host Updating scoop! -BackgroundColor Yellow -ForegroundColor Black
scoop update
# Add buckets:
Write-Host Adding buckets! -BackgroundColor Yellow -ForegroundColor Black
scoop bucket add extras
# # Install powershell 7.2.6
# Write-Host Installing NEW powershell! -BackgroundColor Yellow -ForegroundColor Black
# scoop install pwsh
# # Add newest version to path:
# Write-Host Please update enviromental variables manually! -BackgroundColor Red -ForegroundColor Black
# Write-Host "[1]   RUN THIS COMMAND: explorer.exe `"C:\Users\%USERNAME%\scoop\shims\`"" -BackgroundColor Yellow -ForegroundColor Black
# Write-Host "[1.5]   IF THIS FOLDER DOES NOT EXIST YOU WILL HAVE TO FIND IT MANUALLY!" -BackgroundColor Yellow -ForegroundColor Black
# Write-Host "[2]   OPEN SYSTEM VARIABLES EDITOR:"  -BackgroundColor Yellow -ForegroundColor Black
# Write-Host "[2.1]  -> Search " -BackgroundColor Yellow -ForegroundColor Black
# Write-Host "[2.2]     -> Edit the system environment variables " -BackgroundColor Yellow -ForegroundColor Black
# Write-Host "[2.3]        -> Enviroment variables " -BackgroundColor Yellow -ForegroundColor Black
# Write-Host "[2.4]           -> User variables " -BackgroundColor Yellow -ForegroundColor Black
# Write-Host "[2.5]              -> Path" -BackgroundColor Yellow -ForegroundColor Black
# Write-Host "[2.6]                 -> Edit" -BackgroundColor Yellow -ForegroundColor Black
# Write-Host "[2.6]                    -> New" -BackgroundColor Yellow -ForegroundColor Black
# Write-Host "[2.6]                       -> Write in what folder are your shims: C:\Users\[YOUR USERNAME HERE]\scoop\shims\" -BackgroundColor Yellow -ForegroundColor Black
# I don't trust my programming skills enough to modify sysvars. I DO NOT want to be responsible for broken PCs.
# $p = ";C:\Users\" + $env:UserName +"\scoop\shims\"
# $env:Path += $p
# Add dependencies:
scoop install gsudo