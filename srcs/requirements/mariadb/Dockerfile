FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install -y mariadb-server
RUN apt install -y mariadb-client
RUN rm -rf /var/lib/apt/lists/*

COPY ./conf/conf.sql .
COPY ./tools/mariadb_script.sh .

RUN chmod 777 ./mariadb_script.sh

EXPOSE 3306

ENTRYPOINT [ "./mariadb_script.sh" ]

CMD ["mysqld"]