#include dependencies directly from GitHub
iex (New-Object System.Net.WebClient).DownloadString("https://raw.github.com/saxx/ePunkt.PowerShell-Utilities/master/Download-Dependencies.ps1")


Create-Windows-Task-That-Runs-Every-15-Minutes "ePunkt eRecruiter CronWorker" "c:\eRecruiter\Bin\CronWorker\ePunkt.CronWorker.exe" "" "<THE_USERNAME>" "<THE_PASSWORD>"
Create-Windows-Task-That-Runs-Every-Midnight "Server Backup" "c:\Backup\Backup.bat" "" "<THE_USERNAME>" "<THE_PASSWORD>"
