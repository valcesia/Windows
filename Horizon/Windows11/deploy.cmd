@echo off
rem =================================================================
rem Sample script
rem Notes:
rem   X:\: WinPE default root directory
rem   D:\: WinPE ISO image mount drive path 
rem   E:\: Windows installation ISO image mount drive path
rem   W:\: assigned Windows partition drive on disk 0 and is
rem        specified in disk partiton file CreatePartitions-UEFI.txt  
rem ==================================================================
rem Create partition on disk 0
IF NOT EXIST X:\CreatePartitions-UEFI.txt (
echo File X:\CreatePartitions-UEFI.txt not exist.
GOTO :EOF
)
diskpart /s X:\CreatePartitions-UEFI.txt

rem Get selected edition index
dism /get-wiminfo /wimfile:"E:\sources\install.wim"
IF %ERRORLEVEL% NEQ 0 (
echo Get image info E:\sources\install.wim failed. 
GOTO :EOF
)
set /P Edition=Select OS Edition index number and press Enter:
dism /apply-image /imagefile:"E:\sources\install.wim" /index:%Edition% /applydir:W:\
IF %ERRORLEVEL% NEQ 0 (
echo Apply image to W:\ failed.
GOTO :EOF
)

rem Copy Unattend.xml to root directory
IF EXIST X:\Unattend.xml (
copy X:\Unattend.xml W:\
)

rem Add drivers to applied Windows
IF EXIST X:\drivers (
dism /image:W:\ /add-driver /driver:X:\drivers\ /Recurse
)

rem Create boot entries
bcdboot W:\Windows /s S:

rem Restart
wpeutil reboot