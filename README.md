# transferzones
This script is very useful if you want to transfer your zones on the Primary DNS to the Secondary DNS

1. Ensure that you have root SSH account to the Secondary DNS based on Key method
2. Put this script on the crontab and set this script to check /etc/named.conf on the Primary DNS every 1 hour
