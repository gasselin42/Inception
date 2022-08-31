FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install -y nginx
RUN apt install -y openssl
# RUN rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

COPY ./tools/* .
RUN chmod 777 ./entry.sh

RUN mkdir /etc/nginx/ssl

RUN openssl req -x509 \
	-sha256 -days 3650 \
	-nodes -newkey rsa:2048 \
	-subj "/CN=gasselin.42.fr/C=CA/ST=Quebec/L=Quebec City/O=42 Network/OU=42 Quebec" \
	-keyout /etc/nginx/ssl/server.key \
	-out /etc/nginx/ssl/server.crt

# RUN openssl genrsa -out $SSL_CERT_KEY 2048

EXPOSE 443

ENTRYPOINT [ "./entry.sh" ]

CMD ["nginx", "-g", "daemon off;"]