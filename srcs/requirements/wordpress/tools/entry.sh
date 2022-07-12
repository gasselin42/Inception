#!/bin/bash

set -euxo pipefail

if [ ! -d "/var/www/html" ]; then
	mkdir html
fi

if [ ! -f "/var/www/html/wp-config.php" ]; then

	wp core download --allow-root --path=html/

	wp config create --allow-root \
		--dbname=$DB_NAME \
		--dbuser=$DB_USR \
		--dbpass=$DB_PWD \
		--dbhost=$DB_HOST \
		--path=/var/www/html

	wp core install --allow-root \
		--url=$DOMAIN_NAME \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN_LOGIN \
		--admin_password=$WP_ADMIN_PWD \
		--admin_email=$WP_ADMIN_EMAIL \
		--path=/var/www/html

	wp user create --allow-root \
		$WP_USER_LOGIN \
		$WP_USER_EMAIL \
		--user_pass=$WP_USER_PWD \
		--role=author \
		--path=/var/www/html

	wp theme install twentyten --allow-root
	wp theme activate twentyten --allow-root

fi

exec "$@"