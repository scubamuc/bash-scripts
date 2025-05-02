#Nextcloud snap automatic Adressbook export

```
#!/bin/bash

# Benutzername, Passwort
username="BENUTZERNAME"
password="PASSWORD"

# List URLs
downloadLinks=(
    "https://cloud.example.com/remote.php/dav/calendars/cooper.bin/persnlich/?export"
    # add instance URL's
)
for downloadLink in "${downloadLinks[@]}"
do
    # Der `-J` Schalter sagt curl, den Dateinamen aus dem Content-Disposition Header zu verwenden
    # Der `-O` Schalter speichert die Datei unter ihrem ursprünglichen Namen
    # Die Option `-L` erlaubt curl, Weiterleitungen zu folgen
    # Authentifizierungsdaten werden mit der Option `-u` übergeben
    echo "Downloading from $downloadLink..."
    curl -L -J -O -u "$username:$password" "$downloadLink" --create-dirs -o "./$(basename "$url")"
done

echo "Download abgeschlossen."
```
