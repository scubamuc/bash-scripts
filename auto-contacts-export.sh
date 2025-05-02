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
NCADBNAME="addressbookname"
NCADBLINK="https://$NCTLD/remote.php/dav/addressbooks/users/$NCUSER/$NCADBNAME/?export"
##############################################################
    echo "Downloading from $NCADBLINK..."
    curl -L -J -O -u "$NCUSER:$NCUSERPWD" "$NCADBLINK" --create-dirs -o "./$(basename "$url")"
done

echo "Download abgeschlossen."
```
