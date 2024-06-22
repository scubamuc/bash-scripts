  #!/bin/bash
### Restart Nextcloud cron if it failed ###
### 'sudo snap restart nextcloud.nextcloud-cron' ###
### create cronjob as root to run every 15 min ###

SERVICE=cron.php

if (( $(ps -eo pid,etime,cmd | awk '$2 ~ /[0-9]+:[0-9]{2}:[0-9]{2}/' | grep $SERVICE | wc -l) > 0 )) ; then
    snap restart nextcloud.nextcloud-cron
fi


