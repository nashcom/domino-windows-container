docker run -it --hostname domino.notes.lab --name domino -p 1353:1352 -p 81:80 -p 444:443 -v notesdata:c:\local\notesdata --entrypoint= domino:test cmd.exe