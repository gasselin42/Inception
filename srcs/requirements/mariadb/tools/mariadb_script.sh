#!/bin/bash

set -euxo pipefail

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=root --skip-test-db --rpm > /dev/null
fi

if [ -d $DB_PATH/$DB_NAME ]; then
	echo "$DB_NAME ALREADY EXISTS"
else
	mysqld --user=root --bootstrap < ./conf.sql
fi

exec "$@"