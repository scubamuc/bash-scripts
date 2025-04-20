 #!/bin/bash
#################################################################################
  # Setup Nextcloud snap auto install  -scubamuc- https://scubamuc.github.io/ #
#################################################################################
# This script assumes you are running your test instance behind a reverse proxy  
# managing encryption
#################################################################################
             #  Nextcloud snap auto install, Variables #
NCTLD=cloud.mydomain.tld            
NCADMIN=admin 
NCADMINPW=password
NCADMINMAIL=admin@mydomain.tld
RPROXYIP=192.168.2.xxx
##############################################################
# remove existing Nextcloud snap
	sudo snap remove nextcloud ;
# install latest Nextcloud snap
	sudo snap install nextcloud ;
# setup admin-user
        sudo nextcloud.manual-install $NCADMIN $NCADMINPW ;
# install recommended apps
        sudo nextcloud.occ app:enable calendar ;
        sudo nextcloud.occ app:enable contacts ;
	sudo nextcloud.occ app:enable mail ;
	sudo nextcloud.occ app:enable richdocuments ;
        sudo nextcloud.occ app:enable notes ;
        sudo nextcloud.occ app:enable spreed ; 
##############################################################
# backup working config.php
	sudo cp /var/snap/nextcloud/current/nextcloud/config/config.php /var/snap/nextcloud/current/nextcloud/config/config.php.bak ;
# set language to en
        sudo nextcloud.occ config:system:set default_language --value="en" ;
        sudo nextcloud.occ config:system:set force_language --value="en" ;
# set default phone region
	sudo nextcloud.occ config:system:set default_phone_region --value="GB" ;
# set http compression
	sudo snap set nextcloud http.compression=true ;
# set maintenance windows
	sudo nextcloud.occ config:system:set maintenance_window_start --value="1" ;
# set trusted proxies
	sudo nextcloud.occ config:system:set trusted_proxies 0 --value="$RPROXYIP" ;
# set trusted domains
	sudo nextcloud.occ config:system:set trusted_domains 0 --value="$NCTLD" ;
	sudo nextcloud.occ config:system:set trusted_domains 1 --value="x.$NCTLD" ;
	sudo nextcloud.occ config:system:set trusted_domains 2 --value="y.$NCTLD" ;
# set overwritehostprotocol
	sudo nextcloud.occ config:system:set overwriteprotocol --value="https" ;
# set mail address in user profile for admin user
        sudo nextcloud.occ user:setting $NCADMIN settings email "$NCADMINMAIL"
## Set Email
	sudo nextcloud.occ config:system:set mail_from_address --value="noreply-cloud" ;
	sudo nextcloud.occ config:system:set mail_smtpmode --value="smtp" ;
	sudo nextcloud.occ config:system:set mail_sendmailmode --value="smtp" ;
	sudo nextcloud.occ config:system:set mail_domain --value="mydomain.tld" ;
	sudo nextcloud.occ config:system:set mail_smtpauth --value="1" ;
	sudo nextcloud.occ config:system:set mail_smtphost --value="mail.host.tld" ;
	sudo nextcloud.occ config:system:set mail_smtpport --value="xxx" ;
	sudo nextcloud.occ config:system:set mail_smtpname --value="$NCADMINMAIL" ;
	sudo nextcloud.occ config:system:set mail_smtppassword --value="smtpcredentials" ;
	sudo nextcloud.occ config:system:set mail_smtpsecure --value="ssl" ;
##############################################################
### Install Nextcloud Office and Collabora CODE built in ###
##############################################################
# Set overwrite-cli
	sudo nextcloud.occ config:system:set overwrite.cli.url --value="https://$NCTLD"
# 1. Disable CODE
	sudo nextcloud.occ app:disable richdocumentscode ;
# 2. Disable Nextcloud office
	sudo nextcloud.occ app:disable richdocuments ;
# 3. Delete public_wopi configuration
	sudo nextcloud.occ config:app:delete richdocuments public_wopi_url ;
# 4. Delete wopi_url configuration
	sudo nextcloud.occ config:app:delete richdocuments wopi_url ;
# 5. Enable Nextcloud office
	sudo nextcloud.occ app:enable richdocuments ;
# 6. Enable CODE
	sudo nextcloud.occ app:enable richdocumentscode ;


# truncate logs
	sudo truncate -s 0 /var/snap/nextcloud/current/logs/nextcloud.log
# restart Nextcloud snap
	sudo snap restart nextcloud
exit
