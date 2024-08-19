#!/bin/bash
# Bash script to:
#   - Delete all csv files in the output folder
#   - Close MySQL database, 
#   - Close down docker.

# Variables
###########
DOCKER_COMPOSE="./usr/user1/docker-compose.yml"
FILE_PATH="usr/user1/"
VENV="venv_mac/bin/python3.9"

# Remove Output Files
#####################
echo "Removing all CSV files:"
rm -v outputs/*
echo

# Close MySQL
#############
echo "Removing MySQL Database:"
${VENV} ${FILE_PATH}set_mysql_close.py
echo

# Close Docker
##############
echo "Removing Docker files:"
docker compose -f "${DOCKER_COMPOSE}" down
sleep 5
echo