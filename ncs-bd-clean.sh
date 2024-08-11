#!/bin/bash
echo "SCRIPT TO MAKE NEXTCLOUD FILE SCAN NEW EXTERNAL STORAGE AND PERFORM SOME MAINTENANCE";
echo "1. RESCAN CHANGES AND CLEANUP";
sudo nextcloud.occ files:repair-tree -n -vvv;
sudo nextcloud.occ files:scan --all -n -vvv;
sudo nextcloud.occ files:scan-app-data -n -vvv;
sudo nextcloud.occ files:cleanup -n -vvv;
