Get-Process | Select-Object -First 15 Name, Id, CPU | Out-File -FilePath .\processos.txt
Write-Host "Lista de processos exportada com sucesso!" -ForegroundColor Green