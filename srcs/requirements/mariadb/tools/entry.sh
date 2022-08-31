#!/bin/bash

set -euo pipefail

# sed -i 's/.*bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
# sed -Ei '/^(#)?port/c port = 3306' /etc/mysql/mariadb.conf.d/50-server.cnf
# sed -Ei "/^datadir/c datadir = /var/lib/mysql" /etc/mysql/mariadb.conf.d/50-server.cnf

dataDB=/var/lib/mysql/init_dataDB.sql

if [ ! -f $dataDB ]; then
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --skip-test-db --rpm > /dev/null
	cat > $dataDB <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USR'@'%' IDENTIFIED BY '$DB_PWD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USR'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PWD';
FLUSH PRIVILEGES;
EOF

	mysqld --skip-networking &

	for i in {0..30}; do
		if mariadb -u root -p $DB_ROOT_PWD --database=mysql <<<'SELECT 1;' &> /dev/null; then
			break
		fi
		sleep 1
	done

	if [ "$i" = 30 ]; then
		echo "Cannot connect to databse"
	fi

	mariadb -u root -p $DB_ROOT_PWD < $dataDB && killall mysqld
fi

exec "$@"