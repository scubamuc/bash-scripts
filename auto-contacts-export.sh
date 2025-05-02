 #!/bin/bash
#################################################################################
# Auto-contacts-export  -scubamuc- https://scubamuc.github.io/                  #
#################################################################################
# Nextcloud snap automatic Adressbook export
## create cronjob to backup cotacts wekly on Saturday at 22:00
##  0 22 * * 6 su - <$USER> /home/$USER/bin/cloudsync-contacts.sh
#################################################################################
             #  Nextcloud contacts export #
 cd /home/$USER/Backup/contacts/ ; ## target directory for contacts export 
 curl -L -J -O -u "<user>:<passsword>" "https://cloud.domain.tld/remote.php/dav/addressbooks/users/<nextcloud-user>/<addressbookname>/?export" 

```
