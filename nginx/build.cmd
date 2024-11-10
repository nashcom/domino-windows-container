
set DOWNLOAD_NGINX_URL="http://nginx.org/download/nginx-1.27.2.zip"
set DOCKER_IMAGE=nginx:latest

# Windows 2025
set BASE_IMAGE=mcr.microsoft.com/windows/servercore:ltsc2025

# Windows 11
set BASE_IMAGE=mcr.microsoft.com/windows/servercore:ltsc2022

# Windows 10
set BASE_IMAGE=mcr.microsoft.com/windows/servercore:ltsc2019

docker build --build-arg BASE_IMAGE=%BASE_IMAGE% --build-arg DOWNLOAD_NGINX_URL="%DOWNLOAD_NGINX_URL%" -t %DOCKER_IMAGE% .

