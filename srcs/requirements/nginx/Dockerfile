FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install -y nginx
RUN apt install -y openssl
RUN rm -rf /var/lib/apt/lists/*

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN mkdir /etc/nginx/ssl

RUN openssl req -x509 \
	-sha256 -days 3650 \
	-nodes -newkey rsa:2048 \
	-subj "/C=CA/ST=Quebec/L=Quebec City/O=42 Network/OU=42 Quebec/CN=$DOMAIN_NAME" \
	-keyout /etc/ssl/server.key \
	-out /etc/ssl/server.crt

#RUN openssl genrsa -out $SSL_CERT_KEY 2048

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]