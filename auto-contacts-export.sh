 #!/bin/bash
#################################################################################
# Auto-contacts-export  -scubamuc- https://scubamuc.github.io/                  #
#################################################################################
# Nextcloud snap automatic Adressbook export
## create cronjob to backup cotacts wekly on Saturday at 22:00
##  0 22 * * 6 su - <$USER> /home/$USER/bin/cloudsync-contacts.sh
#################################################################################
             #  Nextcloud contacts export #
 
 curl -L -J -u "<USER>:<PASSWORD>" "https://cloud.domain.tld/remote.php/dav/addressbooks/users/<USER>/<addressbookname>/?export" --output /home/$USER/Backup/contacts/

```
