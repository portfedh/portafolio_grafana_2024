#!/bin/bash
# Bash script to:
#   - Delete output files from a previous user.
#   - Select a user to run the program.
#   - Create the docker containers for the user.
#   - Validate user input file.
#   - Run program scripts to create dashboard. 


# Cleanup any previous files
############################
echo
echo -e "Cleaning outputs directory:"
rm -v outputs/*
echo

# Set up the example user
#########################
# USER_NAME="user1"
# DOCKER_IMAGE="portfedh/portfolio_dashboard:user1_grafana"
# DOCKER_COMPOSE="./usr/user1/docker-compose.yml"
FILE_PATH="usr/user1/"


# Run Docker
############
# echo "Setting Up Docker files:"

# Pull latest image
# docker pull "${DOCKER_IMAGE}"

# Run docker compose
# docker-compose -f "${DOCKER_COMPOSE}" up -d
# echo "MySQL Volume in docker needs extra time to setup the first time it runs."
# read -p 'Select wait time (last successfull test was 40s): ' SLEEP_TIME
# sleep ${SLEEP_TIME}
# echo
# echo "Finished Docker setup."
# echo


# Run Input Validation
######################
echo "Running Input Validation:"
${VENV} input_validation.py ${USER_NAME}
echo


# Run python files
##################
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