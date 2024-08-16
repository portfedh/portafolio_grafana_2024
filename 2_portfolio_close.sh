#!/bin/bash
# Bash script to:
#   - Close MySQL database, 
#   - Delete all csv files
#   - Close down docker.

# Close MySQL
#############
echo "Removing MySQL Database:"
${VENV} ${FILE_PATH}set_mysql_close.py
echo

# Close Docker
##############
echo "Removing Docker files:"
docker-compose -f "${DOCKER_COMPOSE}" down
sleep 5
echo

# Remove Output Files
#####################
echo "Removing all CSV files:"
rm -v outputs/*
echo