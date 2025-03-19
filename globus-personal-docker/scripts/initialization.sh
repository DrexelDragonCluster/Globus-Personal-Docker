#!/bin/bash

# Ensure the script exits on any error
set -e

# # Assign input arguments to variables
# DataPath=$1
# ConfigPath=$2

# Log in to Globus without a local server
globus login --no-local-server

# Create a personal endpoint and capture the output
endpoint_info=$(globus endpoint create --personal "$GLOBUS_ENDPOINT_NAME" 2>&1)

# Extract the Endpoint ID and Setup Key from the output
endpoint_id=$(echo "$endpoint_info" | grep -oP "Endpoint ID: \K[0-9a-f-]+")
setup_key=$(echo "$endpoint_info" | grep -oP "Setup Key: \K[0-9a-f-]+")

# Set the environment variables
export GLOBUS_ENDPOINT_ID="$endpoint_id"
export GLOBUS_SETUP_KEY="$setup_key"

# Change to the Globus Connect Personal directory
cd /home/$CURRENT_USER/globusconnectpersonal-*/

# Finish the Endpoint Setup
./globusconnectpersonal -setup "$GLOBUS_SETUP_KEY"

# Start the Globus Connect Personal service
./globusconnectpersonal -start &

# Append the data path to the config paths
echo "/home/$CURRENT_USER/data,0,1" >> ~/.globusonline/lta/config-paths

# Copy the Globus configuration to the host directory
cp -p -r /home/$CURRENT_USER/.globus* /home/$CURRENT_USER/globus_config