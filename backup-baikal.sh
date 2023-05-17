#!/usr/bin/env sh

################################
# Backup calendar and contacts #
# NOTE:			       #
# - $REMOTE_HOST:~/.my.cnf     #
#   is needed to bypass auth   #
# - MEGA is used client-side   #  
################################

set -e
set -u
set -o pipefail

REMOTE_HOST=dietpi
REMOTE_IP=192.168.178.2
REMOTE_KEY=/home/phil/.ssh/id_dagobah
BACKUP_PATH=/home/phil/Documents/Backup/assegai
DATABASE=baikal

eval $(ssh-agent)
ssh-add $REMOTE_KEY

if [ -e $BACKUP_PATH/$DATABASE.sql ]; then
    mv $BACKUP_PATH/$DATABASE.sql $BACKUP_PATH/$DATABASE.sql.OLD
fi

ssh $REMOTE_HOST@$REMOTE_IP -- "mysqldump $DATABASE > $DATABASE.sql"
rsync $REMOTE_HOST@$REMOTE_IP:~/$DATABASE.sql $BACKUP_PATH --info=progress2
chown phil:phil $BACKUP_PATH/$DATABASE.sql
