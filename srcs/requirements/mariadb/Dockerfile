FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install -y mariadb-server
RUN apt install -y mariadb-client
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld /var/lib/mysql
RUN chmod 777 /var/lib/mysql
RUN chmod 777 /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql
RUN chown -R mysql:mysql /run/mysqld

COPY ./conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/mariadb_script.sh .

RUN chmod 777 ./mariadb_script.sh

EXPOSE 3306

ENTRYPOINT [ "./mariadb_script.sh" ]

CMD ["mysqld"]