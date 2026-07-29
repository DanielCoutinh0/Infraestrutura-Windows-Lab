Get-Service | Where-Object {$_.Status -eq "Running"} | Out-File -FilePath .\servicos_ativos.txt
Write-Host "Lista de serviços em execução exportada!" -ForegroundColor Green