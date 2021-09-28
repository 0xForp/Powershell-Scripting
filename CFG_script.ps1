#Requires -RunAsAdministrator

Write-Host ".....................Instalação do Sysmon........................."

########################### Sys Info ##############################

Get-WmiObject -Class Win32_ComputerSystem

#################### Checar se caminho existe,se n existir criar ####################

$path = "C:\Temp"
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
      Write-Host "`nPasta C:\Temp criada pois não existia"
}
else
{
    Write-Host "`nSalvando em C:\Temp"
}

###################### DOWNLOAD DOS ARQUIVOS #######################
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 # Linha para eliminar o error de SSL/TLS

wget https://download.sysinternals.com/files/Sysmon.zip -O C:\Temp\sysmon.zip
wget https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml -O C:\Temp\sysmonconfig.xml


##################### Extrair aquivo zip (sysmon.zip) para a mesma pasta dos demais arquivos #################

Expand-Archive -LiteralPath 'C:\Temp\sysmon.zip' -DestinationPath C:\Temp

###################### Executar o arquivo sysmon com os parametros listados,if statement pra instalar com base no OS 34/64 #####################

if ((Get-WmiObject win32_operatingsystem | select osarchitecture).osarchitecture -like "64*")
{
    #64 bit
    Invoke-Command -ScriptBlock {cmd.exe /C "C:\Temp\Sysmon64.exe" -i -n -accepteula}

    Write-Host "`n`n`OS 64 bits Detectado."
    Write-Host "`n`n`Script Finalizado, Sysmon64 Instalado com sucesso"
}
else
{
    #32 bit 
    Invoke-Command -ScriptBlock {cmd.exe /C "C:\Temp\Sysmon.exe" -i -n -accepteula}

    Write-Host "`n`n`OS 32 bits Detectado."
    Write-Host "`n`n`Script Finalizado,Sysmon Instalado com sucesso"
}

################################ ligando Windows Remote Management Service e executando a quickconfig ##########################

ECHO Y | cmd /c "winrm quickconfig"

################################ Ligando Windows Event Colector e pondo pra startar quando o windows for iniciado #####################

ECHO S | cmd /c "wecutil qc"

