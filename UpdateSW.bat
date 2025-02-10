@echo off
:: Check if running as admin
openfiles >nul 2>&1
if '%errorlevel%' == '0' (
    goto main
) else (
    echo Requesting administrative privileges...
    powershell start -verb runas '%0'
    exit
)

:main
echo Running as admin...

:: Define log file
set logfile=C:\scheduledtasks\winget_upgrade_log.txt

:: Run winget upgrade and capture output
winget upgrade --all --include-unknown > %logfile%

:: Parse log file to summarize upgrades
echo Summary of Upgraded Packages:
for /f "tokens=1,3 delims= " %%A in ('findstr /c:"Upgrading" %logfile%') do (
    echo %%A to %%B
)

pause
