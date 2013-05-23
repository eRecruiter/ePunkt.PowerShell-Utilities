. "Restore-Database.ps1"

$newDatabaseName = Read-Host "Enter the name of the new database"

Restore-Database "DB_SERVER" (Get-Latest-BackupFile-From-Directory "c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup\*.bak") $newDatabaseName