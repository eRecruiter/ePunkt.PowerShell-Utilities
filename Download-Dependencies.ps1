$wc = New-Object System.Net.WebClient
iex $wc.DownloadString("https://raw.github.com/saxx/ePunkt.PowerShell-Utilities/master/Restore-Database.ps1")
iex $wc.DownloadString("https://raw.github.com/saxx/ePunkt.PowerShell-Utilities/master/Create-Windows-Task.ps1")
iex $wc.DownloadString("https://raw.github.com/saxx/ePunkt.PowerShell-Utilities/master/Update-IIS-Websites.ps1")
iex $wc.DownloadString("https://raw.github.com/saxx/ePunkt.PowerShell-Utilities/master/Update-eRecruiter-Settings.ps1")