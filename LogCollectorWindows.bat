@echo off

::Clears the screen, places a Welcome message and asks the user to input the volume where the software is installled
CLS
ECHO Welcome to XXX Log Collector
ECHO.
SET /p Input="Input the volume where the software is installed: "
ECHO.

::Uses the volume to build the paths to where XXX logs are located

SET LOGSDESK=%input%:\Program Files (x86)\Common Files\XXX\Log
SET LOGSWEB=%input%:\Program Files (x86)\XXX\Web ASPx\log
SET InstallHistory=%input%:\Program Files (x86)\Common Files\XXX
SET LOGSMOBILE=%input%:\Program Files (x86)\XXX\Mobile Server ASPx\log
SET LOGSSTATS=%input%:\Program Files (x86)\XXX\Statistics

::Creates a folder (in the same directory where the batch is being executed) to host all the log files

SET LOGROOT=%~dp0%COMPUTERNAME%_LOGS_%dd%-%m%-%yyyy%
mkdir "%LOGROOT%"


echo Step 1: Creating folder structure for logs...

::Presents a menu with the options to gather the logs

:MENU
ECHO Welcome to XXX Log Collector
ECHO.
ECHO ....................................................
ECHO PRESS 1, 2, 3, 4, 5, 6 or 7 to select your task. Or 8 to exit.
ECHO ....................................................
ECHO.

ECHO 1 - Collect Desktop Logs
ECHO 2 - Collect Statistics Logs 
ECHO 3 - Collect Web Logs
ECHO 4 - Collect Mobile Logs
ECHO 5 - Collect System Information
ECHO 6 - Collect Event Viewer
ECHO 7 - Collect All Logs
ECHO 8 - Exit

SET /p M=Type the option you want and then press Enter: 

::Indicates, based on the users input, which script should be executed

IF %M%==1 GOTO LogsDesk
IF %M%==2 GOTO STATS
IF %M%==3 GOTO Web
IF %M%==4 GOTO Mobile
IF %M%==5 GOTO MSI
IF %M%==6 GOTO Events
IF %M%==7 GOTO All
IF %M%==8 GOTO :EOF

::FOR /F "TOKENS=1,2,3,4,5 DELIMS=/: " %%A IN ('echo %DATE% %TIME%') DO (
::SET dd=%%A
::SET m=%%B
::SET yyyy=%%C
::SET hh=%%D
::set mm=%%E
::)

::Scripts for collecting logs

::Collects Desktop logs (and also .bak00, .bak01 and .bak02) and places them in LOGSDESK folder

:LogsDesk
echo Copying Desktop Logs
if exist "%_LOGSDESK%\" (
  echo    --^>Desktop Log found
  mkdir "%LOGROOT%\%COMPUTERNAME%_LOGSDESK"
  xcopy "%DSSErrors%\DSSErrors.log" "%LOGROOT%\%COMPUTERNAME%_LOGSDESK" /i>nul
  xcopy "%DSSErrors%\DSSErrors.log.bak00" "%LOGROOT%\%COMPUTERNAME%_LOGSDESK" /i>nul
  xcopy "%DSSErrors%\DSSErrors.log.bak01" "%LOGROOT%\%COMPUTERNAME%_LOGSDESK" /i>nul
  xcopy "%DSSErrors%\DSSErrors.log.bak02" "%LOGROOT%\%COMPUTERNAME%_LOGSDESK" /i>nul
  )

::Collects installation history file and places it in InstallHistory folder

if exist "%InstallHistory%\" (
  echo    --^>Install History Found  
  mkdir "%LOGROOT%\%COMPUTERNAME%_InstallHistory"
  xcopy "%InstallHistory%\*.hist" "%LOGROOT%\%COMPUTERNAME%_InstallHistory" /i>nul
)
GOTO MENU

::Collects Statistics log and places it in LOGSSTATS folder

:EM
if exist "%LOGSSTATS%\" (
  echo    --^>Statistics Logs Found  
  mkdir "%LOGROOT%\%COMPUTERNAME%_LOGSSTATS"
  xcopy "%LOGSEM%\MAEntMgr.xml" "%LOGROOT%\%COMPUTERNAME%_LOGSSTATS" /i >nul
)
GOTO MENU

::Collects Web files and places them in LOGSWEB folder

:Web
if exist "%LOGSWEB%\" (
  echo    --^>Web Logs Found  
  mkdir "%LOGROOT%\%COMPUTERNAME%_LOGSWEB"
  xcopy "%LOGSWEB%\templogs*" "%LOGROOT%\%COMPUTERNAME%_LOGSWEB" /i >nul
)
GOTO MENU

::Collects files from Mobile and places them in LOGSMOBILE folder

:Mobile
if exist "%LOGSMOBILE%\" (
  echo    --^>Mobile Logs Found  
  mkdir "%LOGROOT%\%COMPUTERNAME%_LOGSMOBILE"
  xcopy "%LOGSMOBILE%\templogs*" "%LOGROOT%\%COMPUTERNAME%_LOGSMOBILE" /i >nul
)
GOTO MENU

::Collects Event Viewer from System and Application (Only Critical, Error, and Warning messages) and places sthem in two separate txt files

:Events
echo Exporting event logs
wevtutil qe System /rd:true /f:text /q:"*[System[(Level=1 or Level=2 or Level=3)]]" > "%LOGROOT%\%COMPUTERNAME%_System.txt"
wevtutil qe Application /rd:true /f:text /q:"*[System[(Level=1 or Level=2 or Level=3)]]" > "%LOGROOT%\%COMPUTERNAME%_Application.txt"

GOTO MENU

::Collects System Information (installed software, installed Windows Updates, OS Version, CPU and RAM) and places them in three txt files

:MSI
echo Adding System Information and installed software reports

reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr /B ".*DisplayName"> "%LOGROOT%\%COMPUTERNAME%_software.txt"

wmic qfe get Hotfixid > "%LOGROOT%\%COMPUTERNAME%_Hotfixes.txt"

wmic OS get Caption,CSDVersion,OSArchitecture,Version > "%LOGROOT%\%COMPUTERNAME%_msinfo.txt"
wmic CPU get Name,NumberOfCores,NumberOfLogicalProcessors >> "%LOGROOT%\%COMPUTERNAME%_msinfo.txt"
wmic OS get TotalVisibleMemorySize /Value >> "%LOGROOT%\%COMPUTERNAME%_msinfo.txt"

GOTO MENU


::Collects All logs at once

:All
echo Copying Desktop Logs
if exist "%_LOGSDESK%\" (
  echo    --^>Desktop Log found
  mkdir "%LOGROOT%\%COMPUTERNAME%_LOGSDESK"
  xcopy "%DSSErrors%\DSSErrors.log" "%LOGROOT%\%COMPUTERNAME%_LOGSDESK" /i>nul
  xcopy "%DSSErrors%\DSSErrors.log.bak00" "%LOGROOT%\%COMPUTERNAME%_LOGSDESK" /i>nul
  xcopy "%DSSErrors%\DSSErrors.log.bak01" "%LOGROOT%\%COMPUTERNAME%_LOGSDESK" /i>nul
  xcopy "%DSSErrors%\DSSErrors.log.bak02" "%LOGROOT%\%COMPUTERNAME%_LOGSDESK" /i>nul
  )

::Collects Installation History file and places it in InstallHistory folder

if exist "%InstallHistory%\" (
  echo    --^>Install History Found  
  mkdir "%LOGROOT%\%COMPUTERNAME%_InstallHistory"
  xcopy "%InstallHistory%\*.hist" "%LOGROOT%\%COMPUTERNAME%_InstallHistory" /i>nul
)

::Collects Statistics log and places it in LOGSSTATS folder

if exist "%LOGSSTATS%\" (
  echo    --^>Statistics Logs Found  
  mkdir "%LOGROOT%\%COMPUTERNAME%_LOGSSTATS"
  xcopy "%LOGSEM%\MAEntMgr.xml" "%LOGROOT%\%COMPUTERNAME%_LOGSSTATS" /i >nul
)

::Collects Web files and places them in LOGSWEB folder

if exist "%LOGSWEB%\" (
  echo    --^>Web Logs Found  
  mkdir "%LOGROOT%\%COMPUTERNAME%_LOGSWEB"
  xcopy "%LOGSWEB%\templogs*" "%LOGROOT%\%COMPUTERNAME%_LOGSWEB" /i >nul
)

::Collects files from Mobile and places them in LOGSMOBILE folder

if exist "%LOGSMOBILE%\" (
  echo    --^>Mobile Logs Found  
  mkdir "%LOGROOT%\%COMPUTERNAME%_LOGSMOBILE"
  xcopy "%LOGSMOBILE%\templogs*" "%LOGROOT%\%COMPUTERNAME%_LOGSMOBILE" /i >nul
)

::Collects Event Viewer from System and Application (Only Critical, Error, and Warning messages) and places sthem in two separate txt files

echo Exporting event logs
wevtutil qe System /rd:true /f:text /q:"*[System[(Level=1 or Level=2 or Level=3)]]" > "%LOGROOT%\%COMPUTERNAME%_System.txt"
wevtutil qe Application /rd:true /f:text /q:"*[System[(Level=1 or Level=2 or Level=3)]]" > "%LOGROOT%\%COMPUTERNAME%_Application.txt"


::Collects System Information (installed software, installed Windows Updates, OS Version, CPU and RAM) and places them in three txt files

echo Adding System Information and installed software reports

reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr /B ".*DisplayName"> "%LOGROOT%\%COMPUTERNAME%_software.txt"

wmic qfe get Hotfixid > "%LOGROOT%\%COMPUTERNAME%_Hotfixes.txt"

wmic OS get Caption,CSDVersion,OSArchitecture,Version > "%LOGROOT%\%COMPUTERNAME%_msinfo.txt"
wmic CPU get Name,NumberOfCores,NumberOfLogicalProcessors >> "%LOGROOT%\%COMPUTERNAME%_msinfo.txt"
wmic OS get TotalVisibleMemorySize /Value >> "%LOGROOT%\%COMPUTERNAME%_msinfo.txt"

GOTO MENU
