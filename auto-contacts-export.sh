 #!/bin/bash
#################################################################################
# Auto-contacts-export  -scubamuc- https://scubamuc.github.io/                  #
#################################################################################
# Nextcloud snap automatic Adressbook export
#################################################################################
             #  Nextcloud snap contacts export, Variables #
NCTLD="cloud.mydomain.tld"
NCUSER="username"
NCUSERPWD="userpassword"
NCADMIN="admin" 
NCADMINPW="adminpassword"
NCADMINMAIL="admin@mydomain.tld"
RPROXYIP="192.168.2.xxx"
NCLANGUAGE="en"
NCLOCALE="en"
NCREGION="GB"
##############################################################

# List Addressbook URL's
downloadLinks=(
    "https://cloud.example.com/remote.php/dav/calendars/cooper.bin/persnlich/?export"
    # add instance URL's
)
for downloadLink in "${downloadLinks[@]}"
do
    echo "Downloading from $downloadLink..."
    curl -L -J -O -u "$NCUSER:$NCUSERPWD" "$downloadLink" --create-dirs -o "./$(basename "$url")"
done

echo "Download abgeschlossen."
```
