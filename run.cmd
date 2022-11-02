docker run -it -d --hostname domino.notes.lab --name domino -p 1353:1352 -p 81:80 -p 444:443 -p 2050:2050 -v notesdata:c:\local\notesdata hclcom/domino:latest
docker cp setup.json domino:/