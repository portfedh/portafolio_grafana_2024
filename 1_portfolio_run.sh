#!/bin/bash
# Bash script to:
#   - Delete output files from a previous user.
#   - Set up the example user.
#   - Set up the virtual environment.
#   - Run Docker Containers.
#   - Validate user input files.
#   - Create dashboard data. 

# Delete output files from a previous use
##########################################
echo
echo -e "Cleaning outputs directory:"
if [ "$(ls -A outputs)" ]; then
  rm -v outputs/*
fi
echo

# Set up the example user
##########################
DOCKER_IMAGE="portfedh/portfolio_dashboard:user1_grafana_2024_08"
DOCKER_COMPOSE="./usr/user1/docker-compose.yml"
FILE_PATH="usr/user1/"

# Set up the virtual environment
################################
VENV="venv_mac/bin/python3.9"

# Run Docker Containers
########################
echo "Setting Up Docker files:"
# Pull latest image
docker pull "${DOCKER_IMAGE}"
# Run docker compose
docker compose -f "${DOCKER_COMPOSE}" up -d

# If you forget the password, you can reset it with the following command:
##########################################################################
# docker exec -it f06ec9a8b63a grafana-cli admin reset-admin-password newpassword
# admin
# newpassword

echo "MySQL Volume in docker needs extra time to setup the first time it runs."
read -p 'Select wait time (last successfull test was 40s): ' SLEEP_TIME
sleep ${SLEEP_TIME}
echo
echo "Finished Docker setup."
echo

# Validate user input files
###########################
echo "Running Input Validation:"
${VENV} input_validation.py
echo

# Create dashboard data
########################
echo "Executing Portfolio Scripts:"

echo "    - Executing set_mysql_setup."
${VENV} ${FILE_PATH}set_mysql_setup.py

echo "    - Executing get_daily_balance."
${VENV} ${FILE_PATH}get_daily_balance.py

echo "    - Executing get_daily_contributions."
${VENV} ${FILE_PATH}get_daily_contributions.py

echo "    - Executing get_irr."
${VENV} ${FILE_PATH}get_irr.py

echo "    - Executing get_returns."
${VENV} ${FILE_PATH}get_returns.py

echo "    - Executing get_daily_shares."
${VENV} ${FILE_PATH}get_daily_shares.py

echo "    - Executing get_daily_prices."
${VENV} ${FILE_PATH}get_daily_prices.py

echo "    - Executing get_daily_subtotals_single_account."
${VENV} ${FILE_PATH}get_daily_subtotals_single_account.py

echo "    - Executing get_daily_subtotals_all_accounts."
${VENV} ${FILE_PATH}get_daily_subtotals_all_accounts.py