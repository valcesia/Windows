
REM Check if device is already registered with Workspace ONE, if not then proceed with installing Workspace ONE Intelligent Hub
for /f "delims=" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts /s') do set status=%%i
if not defined status goto INSTALL
:INSTALL
REM Run the Workspace ONE Intelligent Hub Installer to Register Device with Staging Account
REM msiexec /i “<PATH>\AirwatchAgent.msi” /quiet ENROLL=Y SERVER=<DS URL>
LGName=<w10-poc> USERNAME=<staging> PASSWORD=<VMware1!> ASSIGNTOLOGGEDINUSER=Y DOWNLOADWSBUNDLE=True /log <PATH TO LOG>
msiexec /i “\\SERVER\AirWatchAgent.msi” /q ENROLL=Y SERVER=ds135.awmdm.com LGName=w10-poc USERNAME=staging PASSWORD=VMware1! ASSIGNTOLOGGEDINUSER=Y DOWNLOADWSBUNDLE=TRUE /LOG %temp%\WorkspaceONE.log

