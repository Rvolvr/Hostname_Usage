<#
.SYNOPSIS
    Change the leader of individual users in bulk
.Description 
    This script will update the user (NT) with the associated manager (Manager) then fill out the organizational information.

.INPUTS
    No parameters are needed when run.

.NOTES
    Our organization has the employee ID as the login and in the Homepage attribute. 

#>

Import-module ActiveDirectory

[array]$export = $null
$list = Import-CSV "\manager_roster.csv"
$Date = Get-Date -UFormat "%Y-%m-%d"



foreach ($Employee in $list){
    $export += Get-ADUser $Employee.NT | Set-ADUser -Verbose @{
        Manager = $Employee.managerID
        Description = $Employee.title
        title = $Employee.title
        office = $Employee.country
        homepage = $Employee.NT
        Department = $Employee.department 
    }
}
$export | Export-Csv ".\Employee_move_$date.csv" -NoTypeInformation