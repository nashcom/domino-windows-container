docker run -it -d --hostname domino.notes.lab --name domino -p 1353:1352 -p 81:80 -p 444:443 -p 2050:2050 -e SetupAutoConfigureParams=c:\setup\DominoAutoConfig.json -v notesdata:c:/local/notesdata -v C:/ContainerData/setup:C:/setup hclcom/domino:latest




