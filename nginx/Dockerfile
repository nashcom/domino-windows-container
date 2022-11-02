FROM mcr.microsoft.com/windows/servercore:ltsc2022

ARG DOWNLOAD_NGINX_URL=
COPY install.ps1 /
RUN powershell.exe -executionpolicy bypass c:\install.ps1
EXPOSE 80 443
ENTRYPOINT [ "/nginx.exe" ]