. "Update-IIS-Websites.ps1"

Create-AppPool-And-Website "eRecruiter" "C:\eRecruiter\Bin\eRecruiter" "C:\eRecruiter\Logs\eRecruiter" "<THE_USER>" "<THE_PASSWORD>"
Set-Http-And-Https-Binding "eRecruiter" "*" "<THE_ERECRUITER_HOST>" "<THE_SSL_CERTIFICATE_THUMBPRINT" 

Create-AppPool-And-Website "Portal" "C:\eRecruiter\Bin\Portal" "C:\eRecruiter\Logs\Portal" "<THE_USER>" "<THE_PASSWORD>"
Set-Http-And-Https-Binding "Portal" "*" "<THE_PORTAL_HOST>" "<THE_SSL_CERTIFICATE_THUMBPRINT" 

Create-AppPool-And-Website "CompanyPortal" "C:\eRecruiter\Bin\eRecruiter" "C:\eRecruiter\Logs\eRecruiter" "<THE_USER>" "<THE_PASSWORD>"
Set-Http-And-Https-Binding "CompanyPortal" "*" "<THE_COMPANYPORTAL_HOST>" "<THE_SSL_CERTIFICATE_THUMBPRINT" 