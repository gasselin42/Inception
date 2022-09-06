FROM debian:buster

EXPOSE 3306

RUN apt update
RUN apt upgrade -y
RUN apt install -y mariadb-server
RUN apt install -y mariadb-client

WORKDIR /tmp

RUN mkdir -p /run/mysqld /var/lib/mysql
RUN chmod 777 /var/lib/mysql
RUN chmod 777 /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql
RUN chown -R mysql:mysql /run/mysqld

COPY ./conf/50-server.conf /etc/mysql/mariadb.conf.d
COPY ./tools/entry.sh .
RUN chmod 777 ./entry.sh

ENTRYPOINT [ "./entry.sh" ]

CMD ["mysqld"]