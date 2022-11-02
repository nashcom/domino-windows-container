FROM mcr.microsoft.com/windows/servercore:ltsc2022

ARG DOWNLOAD_7ZIP_URL=
ARG DOWNLOAD_FROM=
ARG PROD_DOWNLOAD_FILE=

COPY install /install

RUN powershell.exe -executionpolicy bypass c:\install\install.ps1

EXPOSE 80 443 1352 2050
ENTRYPOINT [ "/entrypoint.cmd" ]

