param (
  [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage= "Enter the filename of the snapshot:")]
  [string]$updatefile
)
# Getting the directory where this script is executed.
$script:source = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition) 
$ProgressPreference = "silentlycontinue"

<#
  Compressing the actual Qlik-Connector to a backup archive
#>
function Backup-SnapshotArchive {
  $stamp = Get-Date -Format FileDateTime
  if ((Test-Path -Path "$($script:source)\\backups") -eq $false) {
    New-Item -Path "$($script:source)\\backups" -ItemType Directory
  }
  $filename = "$($script:source)\\backups\\backup-$($stamp).zip"
  Compress-Archive -Path .\qlik-connector\* -DestinationPath $filename -Force 
}

<#
  Remove qlik-connector folder content EXCEPT \logs & \config folders
#>
function Remove-QlikConnector {
  $files = Get-ChildItem -Path "$($script:source)\\qlik-connector" -Force -Recurse | 
  Where-Object { ($_.FullName -cnotmatch "logs") -and ($_.FullName -cnotmatch "config") }
  foreach ($file in $files) {
    if ($file.Attributes -eq "Directory") {
      Remove-Item -Path $file.FullName -Recurse -Force
    }
    else {
      if (Test-Path $file.FullName) {
        Remove-Item -Path $file.FullName -Force
      }
    }
  }
}

<#
  Expand snapshot archive to .\temp folder
#>
function Expand-QlickConnectorSnapshot {
  if ((Test-Path -Path "$($script:source)\\temp") -eq $false) {
    New-Item -Path "$($script:source)\\temp" -ItemType Directory | Out-Null
  }
  Expand-Archive -Path $updatefile -DestinationPath "$($script:source)\\temp" -Force 
}

<#
  Move extracted snapshot files to qlik-connector folder
  & clean temp folder.
#>
function Install-QlikConnectorUpdate {
  Remove-QlikConnector
  $updatepath = (Get-Item($updatefile)).BaseName
  $path ="$($script:source)\temp\$($updatepath)\*" 
  Move-Item -Path $path -Destination "$($script:source)\\qlik-connector\\"
  Unblock-File -Path "$($script:source)\\qlik-connector\\qlik-connector-server.bat"
  Remove-Item -Path "$($script:source)\temp\" -Recurse -Force | Out-Null
}

Backup-SnapshotArchive
Expand-QlickConnectorSnapshot
Install-QlikConnectorUpdate
