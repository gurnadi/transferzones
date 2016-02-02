# transferzones
This script is very useful if you want to transfer your new zones on the Primary DNS to the Secondary DNS

1. Ensure that you have root SSH account to the Secondary DNS based on key method
2. chmod 700 or 755 transferzones.sh
3. Put this script on the crontab and set this script to check /etc/named.conf on the Primary DNS every 1 hour
