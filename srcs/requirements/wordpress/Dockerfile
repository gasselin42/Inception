FROM debian:buster

EXPOSE 9000

RUN apt update
RUN apt upgrade -y
RUN apt install -y curl
RUN apt install -y php-fpm
RUN apt install -y php-mysql
RUN apt install -y php-common
RUN apt install -y mariadb-client

RUN mkdir -p /var/www/html /run/php
WORKDIR /var/www

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv -f wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY ./tools/* .
RUN chmod 777 ./entry.sh

ENTRYPOINT [ "./entry.sh" ]

CMD ["php-fpm7.3", "-F"]

#-F pour force to stay in foreground
#-R pour allow pool to run as root