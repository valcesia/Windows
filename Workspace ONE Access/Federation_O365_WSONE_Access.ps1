# Declaring variables [type based on your environment, just change my environment for yours]

$365Domain          = "valcesia.onmicrosoft.com"
$Domain             = "valcesia.com"
$Authn              = "Federated"
$AccessUri          = "valcesia.vmwareidentity"
$FedName            = "valcesia.com"
$LogOnUri           = "valcesia.vmwareidentity.com"
$PassiveLogOnUri    = "https://valcesia.vmwareidentity.com:443/SAAS/API/1.0/POST/sso"
$ActiveLogOnUri     = "https://valcesia.vmwareidentity.com:443/SAAS/auth/wsfed/active/logon"
$LogOffUri          = "https://login.microsoftonline.com/logout.srf"

# Install AzureAD Module
Install-Module -Name AzureAD

# Install MSOnline Module
Install-Module MSOnline

# Connect to the MSOnline Services
Connect-MsolService

# Create a Service Principal user into Microsoft 365 admin center
$sp = New-MsolServicePrincipal -DisplayName 365Service -Type Password -Value Password

# Assign a role to the user
Add-MsolRoleMember -RoleMemberType ServicePrincipal -RoleName 'User Administrator' -RoleMemberObjectId $sp.ObjectId

# Copying Service Principal Names to be used into Workspace One Access
$sp.ServicePrincipalNames

# Check the domains you have configured under Microsoft 365 admin center
Get-MsolDomain

# Define onmicrosoft.com domain as Default
Set-MsolDomain -Name $Domain -IsDefault 

# Set Authentication type for MSOnline Services along with your VMware Workspace One Access environment
Set-MsolDomainAuthentication `
 -DomainName $Domain `
 -Authentication $Authn `
 -IssuerUri $AccessUri `
 -FederationBrandName $FedName `
 -PassiveLogOnUri $PassiveLogOnUri `
 -ActiveLogOnUri $ActiveLogOnUri `
 -LogOffUri $LogOffUri 

# Set federation settings with your domain configured on Microsoft 365 admin center
Set-MsolDomainFederationSettings -DomainName $Domain 

# Check whether domain is federated or not
Get-MsolDomainFederationSettings -DomainName $Domain
