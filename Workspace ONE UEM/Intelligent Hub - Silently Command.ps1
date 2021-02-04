<#DOWNLOADWSBUNDLE=True#>
msiexec.exe /i "C:\VMW\AirwatchAgent.msi" /q ENROLL=Y SERVER=ds258.awmdm.com LGName=valcesia USERNAME=user PASSWORD=password ASSIGNTOLOGGEDINUSER=Y DOWNLOADWSBUNDLE=True /LOG C:\VMW\Logs\WorkspaceOne.log

<#DOWNLOADWSBUNDLE=False - Computers without internet conection#>
msiexec.exe /i "C:\VMW\AirwatchAgent.msi" /q ENROLL=Y SERVER=ds258.awmdm.com LGName=valcesia USERNAME=user PASSWORD=password ASSIGNTOLOGGEDINUSER=Y DOWNLOADWSBUNDLE=False /LOG C:\VMW\Logs\WorkspaceOne.log

<# Without ASSIGNTOLOGGEDINUSER=Y#>
msiexec.exe /i "C:\VMW\AirwatchAgent.msi" /q ENROLL=Y SERVER=ds258.awmdm.com LGName=valcesia USERNAME=user PASSWORD=password DOWNLOADWSBUNDLE=True /LOG C:\VMW\Logs\WorkspaceOne.log
