
set DOWNLOAD_FROM=http://192.168.96.112:8888

set PROD_DOWNLOAD_FILE=Domino_14.0_Win_English.exe
set DOWNLOAD_7ZIP_URL="https://www.7-zip.org/a/7z2407-x64.exe"

set DOCKER_IMAGE=hclcom/domino:latest

# Windows 2025
set BASE_IMAGE=mcr.microsoft.com/windows/servercore:ltsc2025

# Windows 11
set BASE_IMAGE=mcr.microsoft.com/windows/servercore:ltsc2022

# Windows 10
set BASE_IMAGE=mcr.microsoft.com/windows/servercore:ltsc2019

docker build --build-arg BASE_IMAGE=%BASE_IMAGE% --build-arg DOWNLOAD_FROM="%DOWNLOAD_FROM%" --build-arg PROD_DOWNLOAD_FILE="%PROD_DOWNLOAD_FILE%" --build-arg DOWNLOAD_7ZIP_URL="%DOWNLOAD_7ZIP_URL%" -t %DOCKER_IMAGE% .

