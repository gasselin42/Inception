FROM debian:buster

RUN apt update
RUN apt upgrade -y
RUN apt install -y nginx
RUN apt install -y openssl
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

EXPOSE 443

CMD ["nginx", "-g", "daemon off"]