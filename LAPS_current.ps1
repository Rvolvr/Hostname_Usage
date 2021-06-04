Import-Module ActiveDirectory

$laps = Read-Host 'Please enter LAPS computer name you are trying to lookup'
$lapscomputer = "*$laps*"

Get-ADObject -Filter {name -like $lapscomputer} -property * | Select-Object Name,ms-Mcs-AdmPwd,Modified

Read-Host 'Press Any Key to Close'
