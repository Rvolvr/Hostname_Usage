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
$MyApp = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "Adobe Acrobat DC"}
$MyApp.uninstall()

## Rename computer and join to domain. -Sets the name to the serial number. 
$serial = Get-WmiObject -class win32_bios | Select-Object -ExpandProperty SerialNumber
Add-Computer -DomainName "<DOMAIN>" -newname "$serial" -OUPATH "<DOMAIN OU PATH>"

## Remove (Example all Xbox apps) which were installed my Microsoft Store
Get-AppPackage "*xbox*" | Remove-AppxPackage

## Registry Key to prevent new Microsoft Store items from download (if not using GPO)
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent\" -Name "DisableWindowsConsumerFeatures" -Value 1
