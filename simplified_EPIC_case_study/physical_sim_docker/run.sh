#!/bin/bash

FILE=/home/initialization_done.txt

service mysql restart

# mysql initialization
if ! [[ -f "$FILE" ]]; then
    
    # in order to make only one initialization
    echo "Don't remove this file" >> /home/initialization_done.txt
    
    mysql < mysql_initialization.sql
    mysql -u user -ppassword pandapower_db < /home/Panda-db/pandapower_db_initialization.sql
    
fi

cd Panda-db

# Run simulator
/home/.venv/bin/python3 ./Simulator.py

#tail -f /dev/null
