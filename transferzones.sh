#!/bin/bash
FILE_NAME="/etc/named.conf";
COPY_FILE="/root/script/slaves.conf";
LAST_FILE="/root/script/lastdomain.txt";
SLAVE_IP="y.y.y.y";
MASTER_IP="x.x.x.x";
SSH_PORT=22;
KEY_SSH="/root/script/hosting.key";
DEST_DIR="/etc/";
COMM_REM="/etc/init.d/named reload";

if [ ! -f $LAST_FILE ]; then
    cp $FILE_NAME $LAST_FILE
fi

DIFF=`diff $FILE_NAME $LAST_FILE`;

# this script will be running if $FILE_NAME is not the same with $LAST_FILE

if [ "$DIFF" != "" ]; then
  cp -f $FILE_NAME $LAST_FILE

  for i in `grep zone $LAST_FILE | grep IN | awk -F"\"" '{print $2}'`; do
      echo "zone \"$i\" IN {" >> tmp.txt
      echo "  type slave;" >> tmp.txt
      echo "  allow-query { any; };" >> tmp.txt
      echo "  file \"slaves/db.$i\";" >> tmp.txt
      echo "  masters {" >> tmp.txt
      echo "    $MASTER_IP;" >> tmp.txt
      echo "  };" >> tmp.txt
      echo "};" >> tmp.txt
      echo " " >> tmp.txt
   done

  cp -f tmp.txt $COPY_FILE; rm -f tmp.txt
  scp -P $SSH_PORT -i $KEY_SSH $COPY_FILE root@$SLAVE_IP:$DEST_DIR
  ssh -p $SSH_PORT -i $KEY_SSH root@$SLAVE_IP $COMM_REM
