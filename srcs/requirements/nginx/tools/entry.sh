#!/bin/bash

set -euo pipefail

cat >/etc/nginx/conf.d/default.conf <<EOF
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name	gasselin.42.fr;
    index		index.php index.htm index.html;

    root /var/www/html;

	# ssl on;
    ssl_certificate 	/etc/nginx/ssl/server.crt;
    ssl_certificate_key	/etc/nginx/ssl/server.key;
	ssl_protocols		TLSv1.2 TLSv1.3;

    location / {
		try_files $uri $uri/ /index.php?$query_string;
	}

	location = /404.html {
		internal;
	}

    location ~ \.php$ {
        fastcgi_split_path_info	^(.+\.php)(/.+)$;
        fastcgi_pass			wordpress:9000;
        fastcgi_index			index.php;
        include					fastcgi_params;
        fastcgi_param			SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param			PATH_INFO $fastcgi_path_info;
    }
}
EOF

exec "$@"