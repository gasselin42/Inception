# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gasselin <gasselin@student.42quebec.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/28 13:55:36 by gasselin          #+#    #+#              #
#    Updated: 2022/09/06 14:29:35 by gasselin         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DATADIR = /home/gasselin/data

all: up

up:
	mkdir -p $(DATADIR)
	mkdir -p $(DATADIR)/html
	mkdir -p $(DATADIR)/mysql
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
	rm -rf $(DATADIR)

eval:
	@docker stop $(shell docker ps -qa)
	@docker rm $(shell docker ps -qa)
	@docker rmi -f $(shell docker images -qa)
	@docker volume rm $(shell docker volume ls -q)
	@docker network rm $(shell docker network ls -q)

.PHONY: all up down build clean vclean fclean eval