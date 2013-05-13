. "Update-eRecruiter-Settings.ps1"

Set-ConnectionStrings "Data Source=<THE_SERVER>;Initial Catalog=<THE_DATABASE>;Integrated Security=True;"

Set-AppSettings "WebBasePath" "c:\eRecruiter\Bin\eRecruiter"
Set-AppSettings "FileServerHost" "localhost"
Set-AppSettings "FileServerPort" "35791"