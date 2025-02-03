## Variables
 
$bgInfoFolder = "C:\Bginfo"
$bgInfoRegkey = "BgInfo"
$runPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"

# Remove Bginfo folder from C:
 
If ((Test-Path -Path $bgInfoFolder))
{
       Remove-Item -Path $bgInfoFolder -Recurse 
}
Else
{

}
# Remove Bginfo into Run

$BGInfoKeyExists = (Get-Item $runPath -EA Ignore).Property -contains $bgInfoRegkey

If ($BGInfoKeyExists -eq $True){
    Remove-ItemProperty -Path $runPath -Name $bgInfoRegkey
}

Else {

}