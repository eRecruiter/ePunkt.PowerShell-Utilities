#####################################################################
# This script is supposed to be executed in the directory where all # 
# the eRecruiter applications have their (sub-)directories.         #
#                                                                   #
# It will create or update the AppSettings & the ConnectionStrings  #
# for your eRecruiter installation.                                 #
#####################################################################


#include dependencies directly from GitHub
iex (New-Object System.Net.WebClient).DownloadString("https://raw.github.com/saxx/ePunkt.PowerShell-Utilities/master/Update-eRecruiter-Settings.ps1")


#create or update the connectionstring to the database
Create-Empty-ConnectionStrings-If-Not-Exists ".\CompanyPortal"
Create-Empty-ConnectionStrings-If-Not-Exists ".\eRecruiter"
Create-Empty-ConnectionStrings-If-Not-Exists ".\CronWorker"
Create-Empty-ConnectionStrings-If-Not-Exists ".\Portal"

Set-ConnectionString-Recursive "Data Source=eptsvl12;Initial Catalog=eRecruiter;Integrated Security=True;"


#create or update the appsettings
Create-Empty-AppSettings-If-Not-Exists ".\CompanyPortal"
Create-Empty-AppSettings-If-Not-Exists ".\eRecruiter"
Create-Empty-AppSettings-If-Not-Exists ".\CronWorker"
Create-Empty-AppSettings-If-Not-Exists ".\Portal"

Set-AppSetting-Recursive "WebBasePath" "c:\eRecruiter\Bin\eRecruiter"
Set-AppSetting-Recursive "WindowsFileManager_FilesPath" "c:\eRecruiter\Files\Files"
Set-AppSetting-Recursive "WindowsFileManager_TemplatesPath" "c:\eRecruiter\Files\Templates"
Set-AppSetting-Recursive "TemporaryFileManager_Path" "c:\eRecruiter\Temp"

Set-AppSetting-Recursive "SmtpHost" "localhost"
Set-AppSetting-Recursive "SmtpPort" "25"
Set-AppSetting-Recursive "SmtpUserName" ""
Set-AppSetting-Recursive "SmtpPassword" ""
Set-AppSetting-Recursive "SmtpUseSsl" "false"
Set-AppSetting-Recursive "SmtpSender" "support@epunkt.net"

Set-AppSetting-Recursive "EnableCaching" "false"
Set-AppSetting-Recursive "CacheExpiration" "0"
Set-AppSetting-Recursive "EnableCaching" "true" ".\eRecruiter"
Set-AppSetting-Recursive "CacheExpiration" "10" ".\eRecruiter"

Set-AppSetting-Recursive "RequireSsl" "false"

Set-AppSetting-Recursive "GoogleMapsApiKey" "ABQIAAAAnOKm6VDu6bCBZXPmN9EkrxRm1_h-rqQCrkx63hPUdnka_uoe5hSl6KVXRVNExqskEmBuuBUCt1OABA"

Set-AppSetting-Recursive "LdapPaths" $null
Set-AppSetting-Recursive "EnableIssueTracker" $null
Set-AppSetting-Recursive "EnableEmailOnError" $null
Set-AppSetting-Recursive "BundleCssAndJavaScript" $null
Set-AppSetting-Recursive "EnableProfiler" $null
Set-AppSetting-Recursive "Override_PortalUrl" $null
Set-AppSetting-Recursive "Override_CompanyPortalUrl" $null
Set-AppSetting-Recursive "Override_NeverSendEmailsInCronWorker" $null
Set-AppSetting-Recursive "Override_NeverUseSsl" $null
Set-AppSetting-Recursive "Override_CustomPath" $null
Set-AppSetting-Recursive "ProxyAddress" $null
Set-AppSetting-Recursive "ProxyPort" $null
Set-AppSetting-Recursive "ProxyUser" $null
Set-AppSetting-Recursive "ProxyPassword" $null

Set-AppSetting-Recursive "Portal-MandatorId" $null
Set-AppSetting-Recursive "Portal-MandatorId" 1 ".\Portal"
