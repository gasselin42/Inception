FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install -y mariadb mariadb-client
RUN rm -rf /var/lib/apt/lists/*

COPY ./conf/* /tmp/
COPY ./tools/* /tmp/

RUN chmod 777 /tmp/mariadb_script.sh

EXPOSE 3306

ENTRYPOINT [ "/tmp/mariadb_script.sh" ]

CMD ["mysqld"]