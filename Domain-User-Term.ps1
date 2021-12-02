<#
.SYNOPSIS
Use for disabling and removing a user from groups. 

.DESCRIPTION

Takes a Active Directory user and removes them from the groups. This script also removes the manager link and changes the description. 

.NOTES
Since moving an object in Active Directory requires the path, that option has been omitted. 
#>

# Input of username.
$Term = Read-Host 'Please enter username which will be modified'

$date = Get-Date -UFormat "%Y-%m-%d"
Start-Transcript -Path .\Term_$Term_$date.log

# See if there is an active user.
$Term = get-aduser -filter {SamAccountName -like $Term} | Where-Object Enabled -EQ $true

# If/Else for AD lookup failure.
if ($null -ne $Term){
    Write-Warning -Message "$($term.name) has been found. If this is not the correct user, exit the script (CTRL-C)"

    # Pull each of the groups the user is a member of.

    $principal = Get-ADPrincipalGroupMembership $term | Where-Object name -ne 'Domain Users'
    $creds = Get-Credential -message 'Please enter ADMIN credentials authorized to do this work'

    foreach ($group in $principal) {
        Remove-ADGroupMember -Identity $group -Members $Term -Credential $creds -Confirm:$false
        Write-Output -Message "$($group.Name) has been removed from $($term.Name)"
    }
    
     # Change the user to disabled and set the description.
     Set-ADUser $Term -Verbose @{
        Enabled = $false
        Description = "Termination $date"
        Manager = $null
    }

    # Accidental deletion can prevent moving as well - removing...
    Set-ADObject $Term -ProtectedFromAccidentalDeletion:$false -Verbose


} Else {
    Write-Error -Message 'No active user found'
}
Stop-Transcript