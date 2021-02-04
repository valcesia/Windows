Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

w32tm /config /manualpeerlist:ca.pool.ntp.org,0x8 /syncfromflags:MANUAL /reliable:yes
w32tm /config /update
net stop w32time
net start w32time
w32tm /resync
