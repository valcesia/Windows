<#
.SYNOPSIS
Script to convert VCF files exported from Android devices to CSV format. All CSV format was built to use import format according Microsoft Outlook

.DESCRIPTION
        This script was created for a customer who uses Android Work Managed devices, who don't have a personal Google Account and needs to migrate VCF 
        contact information and import them to Microsoft Outlook accounts. Adding user accounts to Microsoft Exchange can prevent customers from losing 
        their contacts, in case of a problem related to the device itself.

.EXAMPLE
        Example of how to run the script:
        ./vCF2CSV.ps1 -fileName contact.vcf | Export-Csv ./output.csv 

        or to remove " " from CSV file (to be imported using Exchange On-premises)

        ./vCF2CSV.ps1 -fileName contact.vcf | Export-Csv -UseQuotes Never -Encoding UTF8 ./output.csv

.NOTES
  Version:        1.1
  Author:         Thiago Valcesia - thiago.valcesia@broadcom.com
                  
  Creation Date:  03/12/2024
      
  Purpose/Change: Develop a script to facilitate migration from VCF files from Android Work Managed devices, which do not have Google Accounts configured
  
#>
param($fileName = "/Users/tvalcesia/Documents/54.vcf")

function New-Card {
    return [PSCustomObject][ordered]@{'First Name'='';'Middle Name'='';'Last Name'='';'Name'='';'Home Phone'='';'Home Phone 2'='';'Business Phone'='';'Business Phone 2'='';'Mobile Phone'='';'Car Phone'='';'Other Phone'='';'Company'='';'Notes'=''}
}

$content = Get-Content $fileName
$cardCount = 0
$currentCard = New-Card
$state = 'out'

foreach ($line in $content) {
    if ($line -match "^PRODID.*") {
        $state = 'in'
        $cardCount++;
        $currentCard = New-Card
        continue;
    }
    if ($line -match "^END:VCARD.*") {
        $state = 'out'
        $cellphones = 0
        $currentCard
        $currentCard."First Name" = ''
        $currentCard."Last Name" = ''
        $currentCard."Middle Name" = ''
        $currentCard."Name" = ''
        $currentCard."Business Phone 2" = ''
        $currentCard."Home Phone" = ''
        $currentCard."Car Phone" = '' 
        $currentCard."Business Phone" = ''
        $currentCard."Mobile Phone" = ''
        $currentCard."Other Phone" = ''
        $currentCard."Company" = ''
        continue;
    }

    if ($line -match "N:.*;") {
        $tokens = $line -split ":"
        $array = ($tokens[1] -split ';')
        $currentCard."Last Name" = $array[0]
        $currentCard."First Name" = $array[1]
        $currentCard."Middle Name" = $array[2]
    }

    if ($line -match "FN:.*") {
        $tokens = $line -split ":"
        $currentCard."Name" = $tokens[1] -replace "\\,", ","
    }
    if ($line -match "ORG:.*") {
        $tokens = $line -split ":"
        $currentCard."Company" = (($tokens[1] -split ';') -join "`n") -replace "\\,", ","
    }

    if ($line -match "TEL;CELL") {
        $cellphones++
        $tokens = $line -split ":"
        if($cellphones -eq 1){
            $currentCard.'Mobile Phone' = (($tokens[1] -split ';') -join "`n") -replace "\\,", ","
        }
        if ($cellphones -eq 2){
            $currentCard."Car Phone" = (($tokens[1] -split ';') -join "`n") -replace "\\,", ","
        }
        if ($cellphones -eq 3){
            $currentCard."Other Phone" = (($tokens[1] -split ';') -join "`n") -replace "\\,", ","
        }
    }

    if ($line -match "TEL;X-Celular") {
        $cellphones++
        $tokens = $line -split ":"
        if($cellphones -eq 1){
            $currentCard.'Business Phone' = (($tokens[1] -split ';') -join "`n") -replace "\\,", ","
        }
        if ($cellphones -eq 2){
            $currentCard."Other Phone" = (($tokens[1] -split ';') -join "`n") -replace "\\,", ","
        }
    }

    if ($line -match "TEL;HOME") {
        $tokens = $line -split ":"
        $currentCard."Home Phone" = (($tokens[1] -split ';') -join "`n") -replace "\\,", ","
    }

    if ($line -match " TEL;WORK") {
        $tokens = $line -split ":"
        $currentCard."Business Phone 2" = (($tokens[1] -split ';') -join "`n") -replace "\\,", ","
    }
}
