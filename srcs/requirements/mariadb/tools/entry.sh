#!/bin/bash

set -euo pipefail

if [ "$1" = "mysqld" ]; then

	dataDB=/var/lib/mysql/init_dataDB.sql

	if [ ! -f $dataDB ]; then
		mysql_install_db --datadir=/var/lib/mysql --user=mysql --skip-test-db > /dev/null

		cat > $dataDB <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USR'@'%' IDENTIFIED BY '$DB_PWD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USR'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PWD';
FLUSH PRIVILEGES;
EOF

		for i in {0..30}; do
			if mysqld --user=root --password=root --database=mysql <<<'SELECT 1;' &> /dev/null; then
				break
			fi
			sleep 1
		done

		if [ "$i" = 30 ]; then
			echo "Cannot connect to databse"
		fi

		mysqld --user=root --password=root < $dataDB && killall mysqld
	fi

fi

exec "$@"