
  #!/bin/bash

##############################################################
# Script Beschreibung # https://scubamuc.github.io/          #
##############################################################
# Dieses Skript löscht alle Dateien die älter als 7 Tage sind
# aus dem Nextcloud Datenverzeichnis
# Das Skript wird als CRONTAB als Root ausgeführt.
##############################################################
# VARIABLEN #
##############################################################
LOG="/home/$USER/logs/cleanup.log"  ## Logdatei
OLDLOG="/home/$USER/logs/cleanup.old"  ## Logdatei
DATUM=`date +"%F"` ## Datumvariable
ZEIT=`date +"%T"`  ## Zeitvariable
ZIEL="/../../data/__groupfolders/1"  ## Zielverzeichnis
QUELLE="/home/$USER/Pfad" ## Quelldatei
##############################################################
# Script Beginn
##############################################################
## werde root wenn manuell ausgeführt
sudo pwd;
### rigoroses cleanup, Dateien und Ordner!
sudo find $ZIEL -mindepth 2 -mtime +7 >$LOG ;
sudo find $ZIEL -mindepth 2 -mtime +7 -delete ;
###
echo "SCRIPT TO MAKE NEXTCLOUD FILE SCAN NEW EXTERNAL STORAGE AND PERFORM SOME MAINTENANCE";
echo "1. RESCAN CHANGES AND CLEANUP";
sudo nextcloud.occ files:repair-tree -n -vvv;
sudo nextcloud.occ files:scan --all -n -vvv;
sudo nextcloud.occ files:scan-app-data -n -vvv;
sudo nextcloud.occ files:cleanup -n -vvv;
## Nextcloud Trash pro Benutzer und Gruppenordner bereinigen
sudo nextcloud.occ trashbin:cleanup --all-users ;
sudo nextcloud.occ groupfolders:trashbin:cleanup -f ;

exit

