FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install -y curl
RUN apt install -y php-fpm
RUN apt install -y php-mysql
#RUN apt install -y mariadb-client
RUN rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www

WORKDIR /var/www

COPY ./tools/entry.sh .
RUN chmod 777 ./mariadb_script.sh

EXPOSE 9000

ENTRYPOINT [ "./entry.sh" ]

CMD ["php-fpm"]