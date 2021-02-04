# Horizon Client Silently installation with Admin Rights

# Define your variables

$Username = 'Username'
$Password = 'Password'
$FilePath = 'C:\users\Username\Downloads\VMware-Horizon-Client-2006-8.0.0-16531419.exe'
$Argument = '/silent /norestart'

# Convert Password
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential $Username, $SecurePassword

# Execute the Command
Start-Process -FilePath $FilePath -ArgumentList $Argument -Verb runAs
