# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gasselin <gasselin@student.42quebec.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/28 13:55:36 by gasselin          #+#    #+#              #
#    Updated: 2022/08/31 14:12:00 by gasselin         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DATADIR = /home/gasselin/data

all: up

up:
	mkdir $(DATADIR)/html
	mkdir $(DATADIR)/mysql
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

build:
	docker-compose -f ./srcs/docker-compose.yml build

clean:
	docker-compose -f ./srcs/docker-compose.yml down --rmi all

vclean: clean
	docker volume rm $(shell docker volume ls -q)
	@sudo rm -rf /home/gasselin/data/html/*
	@sudo rm -rf /home/gasselin/data/mysql/*

fclean: vclean
	docker rmi debian:buster -f
	rm -rf $(DATADIR)/html
	rm -rf $(DATADIR)/mysql

.PHONY: all up down build clean vclean fclean