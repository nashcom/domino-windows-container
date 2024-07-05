function header {

  param ($TextStr)

  Write-Host
  Write-Host
  Write-Host "--------------------------------------------------------------------------------"
  Write-Host "$TextStr"
  Write-Host "--------------------------------------------------------------------------------"
  Write-Host
}

$InstallStartTime = Get-Date

if( !(Test-Path "c:\temp") )
{
  New-Item -Path c:\temp -ItemType Directory
}


# Read enviroment vars
New-Variable -Name DOWNLOAD_FROM      -Value "$env:DOWNLOAD_FROM"
New-Variable -Name PROD_DOWNLOAD_FILE -Value "$env:PROD_DOWNLOAD_FILE"
New-Variable -Name DOWNLOAD_7ZIP_URL  -Value "$env:DOWNLOAD_7ZIP_URL"

Write-Host
Write-Host "-------------------------------------------------------------------------------------"
Write-Host "DOWNLOAD_FROM      : [$DOWNLOAD_FROM]"
Write-Host "PROD_DOWNLOAD_FILE : [$PROD_DOWNLOAD_FILE]"
Write-Host "DOWNLOAD_7ZIP_URL  : [$DOWNLOAD_7ZIP_URL]"
Write-Host "-------------------------------------------------------------------------------------"
Write-Host

Set-Location c:\temp

header "Installing 7Zip"

Invoke-WebRequest -Uri "$DOWNLOAD_7ZIP_URL" -OutFile "7z-x64.exe"
Start-Process -FilePath "c:\temp\7z-x64.exe" -ArgumentList "/S" -Wait -NoNewWindow

header "Downloading Domino WebKit"

Start-Process -FilePath "curl" -ArgumentList "-LO $DOWNLOAD_FROM/$PROD_DOWNLOAD_FILE" -Wait -NoNewWindow

header "Extracting Domino WebKit"

Start-Process -FilePath "c:\Program Files\7-Zip\7z.exe" -ArgumentList "x -y c:\temp\$PROD_DOWNLOAD_FILE" -Wait -NoNewWindow
Write-Host
Remove-Item "c:\temp\$PROD_DOWNLOAD_FILE"
Copy-Item "c:\install\entrypoint.exe" "c:\entrypoint.exe"
Copy-Item "c:\install\entrypoint.cmd" "c:\entrypoint.cmd"
Copy-Item "c:\install\domino.cmd" "c:\domino.cmd"

header "Running Domino Silent Install -- This takes a while ..."

Start-Process -FilePath "c:\temp\Disk1\InstData\install.exe" -WorkingDirectory "c:\temp\Disk1\InstData" -ArgumentList "-f c:\install\installer.properties -i silent" -Wait -NoNewWindow

header "Moving install data to c:\notesdata.7z"

# Not needed for Domino 14 Move-Item C:\Domino\notes.ini c:\local\notesdata
Start-Process -FilePath "c:\Program Files\7-Zip\7z.exe" -ArgumentList "a -y c:\notesdata.7z c:\local\notesdata" -Wait -NoNewWindow
Write-Host
Remove-Item "c:\local\notesdata" -Recurse

Set-Location \
Remove-Item "c:\temp\*" -Recurse

# Set registry values to ensure server is always starting as normal application not a service
Set-ItemProperty -Path HKLM:\SOFTWARE\HCL\Domino\1 -Name DontAskAgain -Value 1
Set-ItemProperty -Path HKLM:\SOFTWARE\HCL\Domino\1 -Name RunAsService -Value 0

$InstallEndTime = Get-Date
$Duration = $InstallEndTime -$InstallStartTime

header ("Installation completed in " + $Duration.TotalSeconds.ToString("0.0") + " seconds")

Write-Host 
Write-Host
