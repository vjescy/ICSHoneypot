#!/bin/bash

docker kill $(docker ps -q) && docker rm $(docker ps -a -q) && docker volume rm $(docker volume ls -q) && docker rmi $(docker images -q)

