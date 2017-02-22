#!/bin/bash
#Script to make a regular copy of a mysql database and gzip it into the SAVEDIR.

USER="root"
PASSWORD="iparty2"
DATABASE="wechat_iparty"
SAVEDIR="/data/backup/dbs/"

/usr/bin/nice -n 19 /usr/bin/mysqldump -u $USER --password=$PASSWORD --default-character-set=utf8 $DATABASE -c | /usr/bin/nice -n 19 /bin/gzip -9 > $SAVEDIR/$DATABASE-$(date '+%Y%m%d-%H-%M').sql.gz