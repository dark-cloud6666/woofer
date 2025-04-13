@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

cd Items
if not exist null.exe (
color b
echo your "antivirus" deleted the files, or you did not extract them and open the extracted folder, disable your shitty "antivirus" and then re-extract it.
pause>nul
goto end
)

goto spoof

:spoof
title 590-service.
echo spoofing..

null.exe -- "null.sys"
rem yes im a lazy piece of shit
echo done!
goto endsuccess
:endsuccess
taskkill /im wmiprv* /f /t 2>nul>nul
REM this is fucking annoying wmic caches.
taskkill /im wmiprv* /f /t 2>nul>nul
rem yes im a lazy piece of shit ^^^
pause>nul
pause>nul
pause>nul
pause>nul
goto end

:end

