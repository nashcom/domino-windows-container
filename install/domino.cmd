@echo off

set TIMEOUT=90
set command=%1

if "%1"=="" (
  set command=status
)

tasklist /fi "imagename eq nserver.exe" /fo csv | findstr /i nserver.exe >nul 2>nul
if "%errorlevel%"=="0" (
  set DominoStatus=1
) else (
  set DominoStatus=0
)

if "%command%"=="status" (

  if "%DominoStatus%"=="0" (
    echo Domino Server is NOT running
  ) else (
    echo Domino Server is running
  )

  exit /b 0
)

if "%command%"=="start" (

  if "%DominoStatus%"=="1" (
    Domino Server is already running - exiting
    exit /b 0
  )

  echo Starting Domino for Windows
  start /b c:\domino\nserver.exe =c:\local\notesdata\notes.ini
  exit /b 0
)

if not "%command%"=="stop" (
  echo Unknown Command [%1]
  exit /b 1
)

REM Stop command is the last command in the logic to avoid if nesting

if "%DominoStatus%"=="1" (
  echo Stopping Domino for Windows
  start /b c:\domino\nserver.exe =c:\local\notesdata\notes.ini -quit
) else (

  echo Domino Server is not running - No Shutdown needed
  echo Domino for Windows shutdown completed
  exit /b 0
)

echo  ... waiting for shutdown to complete

set /a seconds = 1
:LOOP

tasklist /fi "imagename eq nserver.exe" /fo csv | findstr /i nserver.exe >nul 2>nul
if "%errorlevel%"=="0" (
  set DominoStatus=1
) else (
  set DominoStatus=0
)

if "%DominoStatus%"=="0" (

  echo Domino stopped ^(%seconds% sec^)
  echo Domino for Windows shutdown completed
  exit /b 0
)

Set /a sec_mod = %seconds% %% 10

if "%sec_mod%"=="0" (
  echo  ... waiting %seconds% seconds
)

if %seconds% geq %TIMEOUT% (
  echo [%DATE% %TIME%] Cannot stop Domino server - Timeout rearched after %seconds% seconds
  exit /b 1
)

ping -n 2 -w 1 127.0.0.1  >nul 2>nul

set /a seconds += 1

goto LOOP
