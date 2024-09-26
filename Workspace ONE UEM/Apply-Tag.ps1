<#
.SYNOPSIS
  This script connects to your VMware Workspace ONE UEM environment and apply tags using specified username as a filter
.NOTES
  Version:       	 		1.0
  Author:        		 	Thiago Valcesia
  Initial Creation Date: 	September 24, 2024
.CHANGELOG
1.0 - Initial version, September 2024
#>

# Variables
$UserName = 'kaka_api'
$Password = 'Password'
$ApiKey = 'nl7e379Jmn8Tq6MmdY0dsvRQxPqWkD/z0VY='
# Add your environment data
$ServerURL = 'https://as258.awmdm.com'
# Add your Tag ID
$TagId = 11590
$User = 'tvalcesia'

<#
  This implementation uses Basic authentication.  See "Client side" at https://en.wikipedia.org/wiki/Basic_access_authentication for a description
  of this implementation.
#>
Function Create-BasicAuthHeader {

	Param(
		[Parameter(Mandatory=$True)]
		[string]$username,
		[Parameter(Mandatory=$True)]
		[string]$password
    )

	$combined = $username + ":" + $password
	$encoding = [System.Text.Encoding]::ASCII.GetBytes($combined)
	$encodedString = [Convert]::ToBase64String($encoding)

	Return "Basic " + $encodedString
}

<#
  This method builds the headers for the REST API calls being made to the AirWatch Server.
#>
Function Create-Headers {

    Param(
		[Parameter(Mandatory=$True)]
		[string]$authString,
		[Parameter(Mandatory=$True)]
		[string]$tenantCode
    )

    $header = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $header.Add("Authorization", $authString)
    $header.Add("aw-tenant-code", $tenantCode)
    $header.Add("Accept", "application/json")
    $header.Add("Content-Type", "application/json")

    Return $header
}
Function Tag-DeviceId-User {

    $URL = "$ServerURL/API/mdm/devices/search?user=$User"
    $response = Invoke-RestMethod -Method "GET" -Uri $URL -Headers $headers -ContentType 'application/json' 
    $Ammount = $response.Devices.Count
    #$Ammount
    
    for($n = 0; $n -le ($Ammount-1); $n++){

        $DeviceID = $response.Devices[$n].Id.Value
        $body = "
            {
                `"BulkValues`": {
                    `"Value`": [
                        `"$DeviceID`"
                    ]
                }
            }
        "
        $URL = "$ServerURL/API/mdm/tags/$TagId/adddevices"
        Invoke-RestMethod -Method "POST" -Uri $URL -Headers $headers -ContentType 'application/json' -Body $body 
    }
}

######################
#### Main Process ####
######################

# API Setup
$AuthString = Create-BasicAuthHeader -username $UserName -password $Password
$Headers = Create-Headers -authString $AuthString -tenantCode $ApiKey

# Get Tag
Write-Host "Applying Tags to $Ammount Devices"
Tag-DeviceId-User
