# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gasselin <gasselin@student.42quebec.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/28 13:55:36 by gasselin          #+#    #+#              #
#    Updated: 2022/07/08 14:25:42 by gasselin         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: up

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

build:
	docker-compose -f srcs/docker-compose.yml build

clean:
	docker-compose -f srcs/docker-compose.yml down --rmi all

vclean: clean
	docker volume rm $(shell docker volume ls -q)

.PHONY: all up down build clean vclean