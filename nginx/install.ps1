Start-Process -FilePath "curl" -ArgumentList "-L $env:DOWNLOAD_NGINX_URL -o nginx.zip" -Wait -NoNewWindow
Expand-Archive nginx.zip -DestinationPath /
Remove-Item nginx.zip
Get-ChildItem nginx*/* | Move-Item -Destination /