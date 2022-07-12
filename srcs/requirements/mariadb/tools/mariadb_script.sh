#!/bin/bash

set -euxo pipefail

sed -i 's/.*bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -Ei '/^(#)?port/c port = 3306' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -Ei "/^datadir/c datadir = /var/lib/mysql" /etc/mysql/mariadb.conf.d/50-server.cnf

chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --skip-test-db --rpm > /dev/null
fi

if [ -d $DB_PATH/$DB_NAME ]; then
	echo "$DB_NAME ALREADY EXISTS"
else
	mysqld --user=mysql --bootstrap < ./conf.sql
fi

exec "$@"