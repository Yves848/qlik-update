@rem ##########################################################################
@rem  qlik-connector updater
@rem ##########################################################################

rem @echo off

if [%1]==[/?] goto NOPARAM

@echo off
setlocal
cd /d %~dp0

rem 1. ARCHIVE -----------------------
rem archive existing version: qlik-connector/qlik-connector-server.bat, qlik-connector/bin, qlik-connector/lib
rem delete these files

rem 2. UPDATE  -----------------------
rem expand archive to temp dir
rem copy files to qlik-connector/qlik-connector-server.bat, qlik-connector/bin, qlik-connector/lib
rem delete temp dir
rem powershell Expand-Archive %1 -DestinationPath your_destination %~dp0

rem OR copy from archive: qlik-connector/qlik-connector-server.bat, qlik-connector/bin, qlik-connector/lib
rem https://stackoverflow.com/questions/50138600/powershell-how-to-copy-only-exe-file-from-zip-folder-to-another-folder

rem 3. UNBLOCK -----------------------
rem unblock bat file
rem https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/unblock-file?view=powershell-7.4

exit /b

:NOPARAM
echo Veuillez configurer le qlik-connector à installer (https://repo.pharmagest.com/generic-qlik-local/qlik-connector/)
goto DONE

:DONE
echo Done!
