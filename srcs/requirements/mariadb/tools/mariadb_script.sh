#!/bin/bash

set -euxo pipefail

sed -i 's/.*bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -Ei '/^(#)?port/c port = 3306' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -Ei "/^datadir/c datadir = /var/lib/mysql" /etc/mysql/mariadb.conf.d/50-server.cnf

mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --skip-test-db --rpm > /dev/null

mysqld --skip-networking=1 &
sleep 5

for i in {0..60}; do
	if mariadb -u root -p12345 --database=mysql <<<'SELECT 1;' &> /dev/null; then
		break
	fi
	sleep 1
done

if [ "$i" = 60 ]; then
	echo "Error while starting server"
fi

mariadb -u root -p12345 < ./conf.sql
killall mysqld

exec $@