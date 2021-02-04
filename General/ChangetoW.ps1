# Set Execution Policy
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Set UAC Properly
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0

# Get Windows Volume E:

$drive = Get-WmiObject win32_volume -filter 'DriveLetter = "E:"'

# Check if volume exists and apply change to W:

if($drive.Name -Like "E:\"){
    Set-WmiInstance -input $drive -Arguments @{DriveLetter=”W:”; Label=”DRIVE_W”}
    Write-host 'Drive W: Is properly configured' 
    #Restart-Computer -Force
    }
else{
    Write-host 'Drive W: Was already configured' 
    #Restart-Computer -Force
}