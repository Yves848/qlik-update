# Qlik-connector-updater

The script is used to update Qlick-connector.
It takes one parameter, by name or through the pipeline

Examples :

```
  .\qlik-connector-updater.ps1 -updatefile .\qlik-connector-1.1.0-SNAPSHOT.zip
```
or 

```
  .\qlik-connector-1.1.0-SNAPSHOT.zip | .\qlik-connector-updater.ps1
```

The "updatefile" parameter is **Mandatory**

## Functions
- *Backup-SnapshotArchive*
  
  Make a zip backup of the installed qlik-connector.
  The backup is stored in a "\Backups" folder.
  The name is structured as "Backup-YYYYMMDDTHHMMSSmmm.zip" 
  ### Remark :
  Now, the backups stay in the "\Backups" folder.  No automatic delete or move procedure is in place.
---
- *Remove-QlikConnector*
  
  Remove the installed qlik-connector
---
- *Expand-QlickConnectorSnapshot*
  
  Expand the .zip file specified in -updatefile script parameter.
  It's expanded in "\Decomp" folder which is cleared once the new snapshot is installed.
---
- *Install-QlikConnectorUpdate*
  
  Move the expanded new click connector found in "\Decomp" folder.
  Once moved, the "\Decomp" folder is wiped.

