#!/bin/bash

set -euo pipefail

for i in {0..30}; do
	if mariadb -h$DB_HOST -u$DB_USR -p$DB_PWD --database=$DB_NAME <<< 'SELECT 1;' &>/dev/null; then
		break
	fi
	sleep 1
done

if [ "$i" = 30 ]; then
	echo "Can't connect to database"
fi

if [ ! -f "/var/www/html/wp-config.php" ]; then

	wp core download --allow-root --path="/var/www/html"
	rm -f /var/www/html/wp-config-sample.php

	wp config create \
		--allow-root \
		--dbname=$DB_NAME \
		--dbuser=$DB_USR \
		--dbpass=$DB_PWD \
		--dbhost=$DB_HOST \
		--dbcharset="utf8" \
		--dbcollate="utf8_general_ci" \
		--path="/var/www/html"

	wp core install \
		--allow-root \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_LOGIN}" \
		--admin_password="${WP_ADMIN_PWD}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--skip-email \
		--url="${DOMAIN_NAME}" \
		--path="/var/www/html"

	wp user create \
		--allow-root \
		$WP_USER_LOGIN \
		$WP_USER_EMAIL \
		--role=author \
		--user_pass=$WP_USER_PWD \
		--path="/var/www/html"

	wp theme install twentyten --allow-root --activate --path="/var/www/html"

fi

exec "$@"