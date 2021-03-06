#Some of the stuff in here requires elevated permissions. Start a blue powershell window :)
Start-Process powershell -Verb runas 


$instancename = "Test1"
$computername = "TSQLWS1"
$majorversion = "2019"
$latestSP = "RTM"
$latestCU = "CU7"
$patchPath = "\\$computername\sqlpatches"
$versionstring = "SQL$majorversion$latestSP$latestCU"
$fullname = "$computername\$instancename"
$buildNumber = (get-dbainstanceproperty -sqlinstance $fullname -InstanceProperty VersionString).Value 
$buildRef = Get-DbaBuildReference -Build $buildNumber -update  # <-- Note the -Update switch!!

#check current version
$buildref 

Test-DbaBuild -SqlInstance sql1 -SqlCredential $cred -MaxBehind "0CU"

$versionstring

#If current version is old stuff, update it using latest CU
Update-DbaInstance -InstanceName $fullname -Version $versionstring  -Path $patchPath -WhatIf 

#Let's try without -WhatIf
Update-DbaInstance -ComputerName $computername -InstanceName $instancename -Version $versionstring -ExtractPath "$patchpath\temp" -Path $patchPath 

