FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install -y mariadb-server
RUN apt install -y mariadb-client
# RUN rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY ./conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/entry.sh .

EXPOSE 3306

ENTRYPOINT [ "./entry.sh" ]

CMD ["mysqld"]