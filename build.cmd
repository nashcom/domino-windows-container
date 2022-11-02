
set DOWNLOAD_FROM=http://192.168.96.10:8888
set PROD_DOWNLOAD_FILE=Domino_12.0.2_Win_English_EAP5.exe
set DOWNLOAD_7ZIP_URL="https://www.7-zip.org/a/7z2201-x64.exe"
set DOCKER_IMAGE=hclcom/domino:latest

docker build --build-arg DOWNLOAD_FROM="%DOWNLOAD_FROM%" --build-arg PROD_DOWNLOAD_FILE="%PROD_DOWNLOAD_FILE%" --build-arg DOWNLOAD_7ZIP_URL="%DOWNLOAD_7ZIP_URL%" -t %DOCKER_IMAGE% .


