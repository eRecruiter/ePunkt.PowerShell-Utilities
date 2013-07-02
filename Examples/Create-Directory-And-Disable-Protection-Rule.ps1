#include dependencies directly from GitHub
iex (New-Object System.Net.WebClient).DownloadString("https://raw.github.com/smidi/ePunkt.PowerShell-Utilities/master/Create-Directory-And-Disable-Protection-Rule.ps1")

$DirectoryPath = "c:\Applications\"

$temp = "Temp\"
$log = "Log\"
$bin = "Bin\"

$eRecruiter = "eRecruiter\"
$portal = "Portal\"
$companyPortal = "CompanyPortal\"
$cronWorker = "CronWorker\"


Create-Directory-And-Disable-Protection-Rule($DirectoryPath)

Set-Read-Rights-For-User $DirectoryPath "Domain\user"
Set-Read-Modify-Rights-For-User $DirectoryPath "Domain\user"
Set-FullControl-For-Users $DirectoryPath @("Domain\user" , "Domain\user2")

Create-Directory-And-Disable-Protection-Rule($DirectoryPath + $bin + $eRecruiter)
Create-Directory-And-Disable-Protection-Rule($DirectoryPath + $bin + $portal)
Create-Directory-And-Disable-Protection-Rule($DirectoryPath + $bin + $companyPortal)
Create-Directory-And-Disable-Protection-Rule($DirectoryPath + $bin + $cronWorker)

Create-Directory-And-Disable-Protection-Rule($DirectoryPath + $log)
Create-Directory-And-Disable-Protection-Rule($DirectoryPath + $temp)