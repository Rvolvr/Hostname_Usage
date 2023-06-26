<#
.Synopsis
Pulls user information from Active Directory and creates Home Directory folder.

.Description
This script will automate the process of creating Home Directories as they are posted in Active Directory user information. The User will then be given FULL CONTROL of the folder in question.

.Notes
$user is mandatory parameter.
Requires Active Directory module to be installed.
Pulls domain from WMI of user running the script.
#>

# Define mandatory username
param (
    [Parameter(Mandatory = $true)]
    [string] $user
)
# Pull information from Active Directory
$ADUser = get-aduser -filter "samaccountname -like '$user'" -Properties homedirectory

# Switch to prevent multiple IF/ELSE calls
switch ($ADUSER) {
    # Incorrectly Searching ADUser with Filter will result in $Null, throw custom error.
    $null {Write-Error 'User not found.'; Break}
    # If the field has not been filled in
    ($null -eq $ADUser.HomeDirectory) {Write-Error 'User not configured properly';Break}
    # If the path on homedirectory already exists, this throws an error.
    (Test-Path $ADuser.homedirectory) {Write-Error 'Folder already exists.';Break}
    # If all else works, DO IT. 
    Default {
        # Create folder
        New-Item -ItemType Directory -Path $ADuser.homedirectory -Verbose
        # Pull new folder current security properties
        $ACL = Get-ACL -Path $ADuser.homedirectory
        # Create rule then merge that information into the variable
        $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$(Get-WmiObject -Class Win32_NTDomain | Select-Object -ExpandProperty domainname )\$($ADUser.SamAccountName)",'FullControl','ContainerInherit,ObjectInherit','NoPropagateInherit','Allow')
        $ACL.SetAccessRule($AccessRule)
        # Overwrite existing rule with merged variable.
        $ACL | Set-Acl -Path $ADuser.homedirectory -Verbose}
}
