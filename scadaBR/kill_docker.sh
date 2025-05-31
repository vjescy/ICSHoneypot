#!/bin/bash

# Stop and remove all containers
sudo docker rm -f $(sudo docker ps -aq)

# Remove all images
sudo docker rmi -f $(sudo docker images -q)

# Remove all user-defined networks (excluding default ones)
sudo docker network rm $(sudo docker network ls --filter type=custom -q)
