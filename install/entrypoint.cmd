@echo off
echo Domino Container Entrypoint for Windows 0.2.0
echo ---------------------------------------------
echo:

set DOMINO_DATA_PATH=c:\local\notesdata
set DOMINO_AUTO_CONFIG_JSON_FILE=%DOMINO_DATA_PATH%\DominoAutoConfig.json
set SetupAutoConfigureParams=c:\setup.json

if not exist "%DOMINO_DATA_PATH%\notes.ini" (
  echo Extracting data directory
  echo ---------------------------------------------

  cd c:\local
  "c:\Program Files\7-Zip\7z.exe" x -y c:\notesdata.7z

  echo ---------------------------------------------
  echo:
)

if exist "%DOMINO_DATA_PATH%\names.nsf" (
  echo Starting Domino server ...
  echo:
  start /b c:\domino\nserver.exe =c:\local\notesdata\notes.ini

) else (

  if exist "%SetupAutoConfigureParams%" (
    echo Configuring Domino via OneTouchSetup ...
    echo:
    start /b c:\domino\nserver.exe =c:\local\notesdata\notes.ini -a %SetupAutoConfigureParams%

  ) else (

    echo Starting Domino server in listen mode on port 1352 ...
    echo:
    start /b c:\domino\nserver.exe =c:\local\notesdata\notes.ini -listen 1352
  )
)

pause 