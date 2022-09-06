FROM debian:buster

EXPOSE 443

RUN apt update
RUN apt upgrade -y
RUN apt install -y nginx
RUN apt install -y openssl
RUN apt-get clean autoclean
RUN apt-get autoremove --yes

COPY ./conf/* /etc/nginx/http.d/default.conf

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 \
	-sha256 -days 3650 \
	-nodes -newkey rsa:2048 \
	-subj "/CN=gasselin.42.fr/C=CA/ST=Quebec/L=Quebec City/O=42 Network/OU=42 Quebec" \
	-out /etc/ssl/gasselin.pem \
	-keyout /etc/ssl/gasselin.key

CMD ["nginx", "-g", "daemon off;"]