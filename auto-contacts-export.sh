 #!/bin/bash
#################################################################################
# Auto-contacts-export  -scubamuc- https://scubamuc.github.io/                  #
#################################################################################
# Nextcloud snap automatic Adressbook export
#################################################################################
             #  Nextcloud snap contacts export, Variables #
NCTLD="cloud.mydomain.tld" # Nextcloud TLD
NCUSER="username" # Username
NCUSERPWD="userpassword" #Userpassword
NCADBNAME="addressbookname" #Addressbook name
DWNLDPATH="/home/user/contactsbackup"
NCADBLINK="https://$NCTLD/remote.php/dav/addressbooks/users/$NCUSER/$NCADBNAME/?export" 
NCADBFULLLINK="https://cloud.example.com/remote.php/dav/addressbooks/users/username/contacts/?export"  #optional Addressbook link
##############################################################
    echo "Downloading from $NCADBLINK..."
    curl -L -J -O -u "$NCUSER:$NCUSERPWD" "$NCADBLINK" --create-dirs -o "$DWNLDPATH"
done

echo "Download complete."
```
