#!/bin/bash

# backup-caldav: backup baikal db to mega

set -e
set -u
set -o pipefail

BAIKAL_DIR=/var/www/html/baikal
REMOTE_DIR=/Backup/caldav
WORK_DIR=/home/phil/backup
DATABASE=baikal

if [ ! -f ~/.my.cnf ]; then
    echo "~/.my.cnf credential file not found - cannot export database!"
    echo "Aborting."
fi

TIMESTAMP=$(date +%Y%m%d_%H-%M-%S)
mysqldump "$DATABASE" > "$WORK_DIR/$DATABASE.sql"
BACKUP_ARCHIVE=$WORK_DIR/baikal-$TIMESTAMP.tar.gz
tar czf "$BACKUP_ARCHIVE" "$BAIKAL_DIR" "$DATABASE.sql"

mega-put -c --ignore-quota-warn "$BACKUP_ARCHIVE" $REMOTE_DIR

