#!/bin/env bash

# Set permissions for shared-data
mkdir -p /shared-data
chmod -R 777 /shared-data
chmod -R 777 /home/gridftp

if [ "$START_GLOBUS" = "true" ]; then
    echo "Starting Globus Connect Personal"
    su gridftp -c "cd /home/gridftp && source ./globus-connect-personal.sh"
else
    su gridftp -c "cd /home/gridftp && source ./initialization.sh"
fi

echo setup complete

# Keep the terminal open
tail -f /dev/null