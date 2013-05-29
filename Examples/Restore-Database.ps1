#include dependencies directly from GitHub
iex (New-Object System.Net.WebClient).DownloadString("https://raw.github.com/saxx/ePunkt.PowerShell-Utilities/master/Download-Dependencies.ps1")

$newDatabaseName = Read-Host "Enter the name of the new database"
Drop-And-Restore-Database "DB_SERVER" (Get-Latest-BackupFile-From-Directory "c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup\*.bak") $newDatabaseName