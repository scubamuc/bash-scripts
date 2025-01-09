  #!/bin/bash

##############################################################
# Script description  -scubamuc- https://scubamuc.github.io/ #
##############################################################
# Script to display system information and status of Nextcloud
# snap server. 
# Required packages:
# Sysstat: `sudo apt install sysstat`
# Snapd: `sudo apt install snapd`
# Nextcloud snap: `sudo snap install nextcloud`
##############################################################
# VARIABLES #
##############################################################
LOG="/home/$USER/script.log"  ## Log file
DATE=`date +"%F"` ## Date format
TIME=`date +"%T"`  ## Time format
TARGET="/home/$USER/path"  ## Target path
SOURCE="/home/$USER/path" ## Source path
LAN=$(ls /sys/class/net | grep 'br0') ## Eternet Interface
WIFI=$(ls /sys/class/net | grep 'wlx') ## Wireless Interface
EXTIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
##############################################################
# FUNCTIONS #
##############################################################
## Check if reboot is required ##
CheckReboot()
	{
	[ -f /var/run/reboot-required ] && echo "Reboot required" || echo "No reboot needed"
	}

## Check if updates are available ##
CheckUpdates()
	{
	sudo /usr/lib/update-notifier/update-motd-updates-available
	}

## Check snap services ##
CheckSnapDienste()
        {
        snap services nextcloud
        }

##############################################################
# Script
##############################################################
	clear
	sudo pwd # needs root privileges, enter "sudo" credentials
	clear
echo '   Hallo '$USER', welcome to '$HOSTNAME'!   ' 
echo ''
echo '=========================================   '
echo '       System information!                       '
echo ''
	echo     "	      Host: "$HOSTNAME ;
	echo     "	      Date: "$DATE ;
	echo     "	      Time: "$TIME  ;
  	echo -ne "	    LAN-IP: "; hostname -I ;
	echo -ne "	    EXT-IP: "$EXTIP ;
echo ''
	hostnamectl;
echo ''
echo '-------------------------------------------------'
echo '        System services and messages!            '
echo ''
	echo -ne "	Nextcloud service:	"; snap services nextcloud.apache | grep 'nextcloud' >/dev/null && echo "running!" || echo "stopped!"
	echo -ne "	   Nextcloud cron:	"; snap services nextcloud.nextcloud-cron | grep -oPw 'active' >/dev/null && echo "running!" || echo "stopped!"
	echo -ne "	  System up since:	"; uptime -p ; #check uptime
	echo -ne "	 	Last boot:	"; last reboot -F | head -1 | awk '{print $5,$6,$7,$8,$9}' ; #check last boot
	echo -ne "	  Reboot required?	"; CheckReboot; #check reboot required
##	echo -ne "        Current CPU load:      "; mpstat
echo ''
## sar -p | tail -1
echo ''
echo '-------------------------------------------------'
echo '       Snap version installed!                   '
echo ''
        echo    "       -- Current Snap version: "
        snap version    # list Snap information
echo ''
        echo    "       -- Nextcloud Snap revisions -- "
        snap list nextcloud --all # Listet Nextcloud Info's
echo ''
        echo    "       -- Nextcloud Snap Services -- "
        sudo snap services nextcloud #Listet Nextcloud Dienste
echo ''
echo '       ==================================   '
	read -p "  Enter to continue... Crtl+c to close..."
echo ''
	clear
echo ''
echo '        Memory and disk usage overview!    '
echo ''
echo '       ==================================   '
echo '       Memory used System!            '
echo ''
	sudo free -tmh
echo ''
echo '       ==================================   '
echo '       Disk space!  			  '
echo ''
        sudo lsblk -e7 -o NAME,SIZE,FSUSED,FSUSE%,FSAVAIL | grep -v "ram" # List drives excluding loop (-e7 = loop) and ram
echo ''
echo '  Disovering disk usage, please wait... '
echo ''
	cd / && sudo du -hsx --exclude=proc * | sort -rh | head -5
echo ''
echo '-------------------------------------------------'
echo '       Disk usage Nextcloud snap data directory!         '
echo ''
	sudo du -hs /var/snap/nextcloud/common/nextcloud/data
echo ''
echo '-------------------------------------------------'
echo '       Largest file in Nextcloud data directory!    '
echo ''
	sudo find /var/snap/nextcloud/common/nextcloud/data -type f -printf "%s\t%p\n" | sort -n | tail -1 &&
echo ''
echo '-------------------------------------------------'
echo '       Nextcloud log size!                  '
echo ''
	sudo du -hs /var/snap/nextcloud/current/logs/nextcloud.log
echo ''
echo '-------------------------------------------------'
echo '       Last log entries in Nextcloud log         '
echo ''
	sudo tail -n5 /var/snap/nextcloud/current/logs/nextcloud.log
echo ''
	read -p "  Enter to continue... Crtl+c to close..."
echo ''
	clear
echo ''
echo '       Logins and security!   '
echo ''
echo '       ==================================   '
echo ''
echo '-------------------------------------------------'
echo '       Last logins and system tasks              '
echo ''
	last -aFixn 5  ;
echo ''
echo ''
echo '-------------------------------------------------'
echo '       Last unsuccessfull logins    '
echo ''
		sudo lastb -aFin 5 ;
echo ''
