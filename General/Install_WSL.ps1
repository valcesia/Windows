# Option 1
## Enable WSL - Windows Subsystem Linux
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# Option 2
## Install Virtual Machine Platform
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

## Enable Virtual Machine Platform
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# WSL Version
## Check Version
wsl --list --verbose

## Set Version 2
wsl --set-default-version 2

# Download Distribution
## Check available distribution options:

<#
Ubuntu 16.04 → https://aka.ms/wsl-ubuntu-1604
Ubuntu 18.04 → https://aka.ms/wsl-ubuntu-1804
Ubuntu 18.04 ARM → https://aka.ms/wsl-ubuntu-1804-arm
Debian GNU/Linux → https://aka.ms/wsl-debian-gnulinux
Kali Linux → https://aka.ms/wsl-kali-linux
OpenSUSE Leap 4.2 → https://aka.ms/wsl-opensuse-42
SUSE Linux Enterprise Server 12 → https://aka.ms/wsl-sles-12
Fedora Remix for WSL → https://github.com/WhitewaterFoundry/Fedora-Remix-for-WSL
#>

Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile c:\temp\Ubuntu.appx -UseBasicParsing

## Install Package
Add-AppxPackage c:\Temp\Ubuntu.appx
