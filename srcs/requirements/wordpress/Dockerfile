FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install -y curl
RUN apt install -y php-fpm
RUN apt install -y php-mysql
RUN apt install -y php-common
RUN apt install -y mariadb-client
RUN rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www /run/php

WORKDIR /var/www

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY ./tools/* .
RUN chmod 777 ./entry.sh

EXPOSE 9000

ENTRYPOINT [ "./entry.sh" ]

CMD ["php-fpm7.3", "-F", "-R"]

#-F pour force to stay in foreground
#-R pour allow pool to run as root