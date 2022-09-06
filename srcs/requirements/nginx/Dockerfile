FROM debian:buster

EXPOSE 443

RUN apt update
RUN apt upgrade -y
RUN apt install -y nginx
RUN apt install -y openssl
RUN apt-get clean autoclean
RUN apt-get autoremove --yes

COPY ./conf/default.conf /etc/nginx/conf.d

RUN openssl req -newkey rsa:4096 \
	-x509 -sha256 -days 365 -nodes \
	-out /etc/ssl/gasselin.pem \
	-keyout /etc/ssl/gasselin.key \
	-subj "/C=CA/ST=Quebec/L=Quebec/O=42 School/OU=gasselin/CN=gasselin.42.fr"

CMD ["nginx", "-g", "daemon off;"]