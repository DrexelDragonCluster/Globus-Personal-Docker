#!/bin/env bash

# Set permissions for shared-data
mkdir -p /home/$CURRENT_USER/shared-data
chmod -R 777 /home/$CURRENT_USER/shared-data
chmod -R 777 /home/$CURRENT_USER

if [ "$START_GLOBUS" = "true" ]; then
    echo "Starting Globus Connect Personal"
    su $CURRENT_USER -c "cd /home/$CURRENT_USER && source ./globus-connect-personal.sh"
else
    su $CURRENT_USER -c "cd /home/$CURRENT_USER && source ./initialization.sh"
fi

echo setup complete

# Keep the terminal open
tail -f /dev/null