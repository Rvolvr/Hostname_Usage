Import-Module ActiveDirectory

$laps = Read-Host 'Please enter LAPS computer name you are trying to lookup'
$lapscomputer = "*$laps*"

Get-ADObject -Filter {(isdeleted -eq $true) -and (name -ne "Deleted Objects") -and (name -like $lapscomputer)} -includeDeletedObjects -property * | Select-Object Name,ms-Mcs-AdmPwd,Modified

Read-Host 'Press Any Key to Close'
