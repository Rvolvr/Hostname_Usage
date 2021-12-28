<#
.Description
Reference place to copy useful snippets.
#>

#Not to be run as a whole --DO NOT REMOVE--
Exit

## Uninstall an app from command line. Adobe Acrobat by example.
$MyApp = Get-WmiObject -Class Win32_Product | Select-Object name
$MyApp
### 
$MyApp = Get-WmiObject -Class Win32_Product | Where-Object Name -eq 'Dell SupportAssist'
$MyApp.uninstall()

## Rename computer and join to domain. -Sets the name to serial number.   
$object = Get-WmiObject -class win32_bios
Add-Computer -DomainName '<DOMAIN>' -newname "$($object.SerialNumber)" -OUPATH '<DOMAIN OU PATH>'

## Reset User Password expiration without changing password
set-aduser $user -Replace @{pwdlastset = 0}
set-aduser $user -Replace @{pwdlastset = -1}

## Remove (Example all Xbox apps) which were installed my Microsoft Store
Get-AppPackage "*xbox*" | Remove-AppxPackage

## Registry Key to prevent new Microsoft Store items from download (if not using GPO)
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent\' -Name 'DisableWindowsConsumerFeatures' -Value 1
