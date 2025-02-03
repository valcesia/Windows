## Variables
 
$bgInfoFolder = "C:\Bginfo"
$bgInfoRegkey = "BgInfo"
$bgInfoRunValue = "C:\BgInfo\Bginfo.exe C:\BgInfo\Default.bgi /timer:0 /nolicprompt"
$runPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"

# Create Bginfo folder on C:
 
If (!(Test-Path -Path $bgInfoFolder))
{
       New-Item -ItemType Directory -Force -Path $bgInfoFolder
}
Else
{

}

# Copy Files to C:\Bginfo\

Copy-Item "$PSScriptRoot\*" -Destination $bgInfoFolder -Recurse -Force

# Add Bginfo into Run

$BGInfoKeyExists = (Get-Item $runPath -EA Ignore).Property -contains $bgInfoRegkey

If ($BGInfoKeyExists -eq $False){
    New-ItemProperty -Path $runPath -Name $bgInfoRegkey -PropertyType String -Value $bgInfoRunValue
}

Else {

}

# Run BGInfo

C:\BgInfo\Bginfo.exe C:\BgInfo\Default.bgi /timer:0 /nolicprompt
Start-Sleep 3 
