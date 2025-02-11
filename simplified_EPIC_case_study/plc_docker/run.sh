#!/bin/bash

SQL_SCRIPT="INSERT INTO Programs (Name, Description, File, Date_upload) VALUES ('singlesub', 'Descrizione', 'singlesub.st', strftime('%s', 'now'));"
SQL_AUTOST="UPDATE Settings SET Value = 'true' WHERE Key = 'Start_run_mode';"

FILE=/home/OpenPLC61850/started.txt

# openplc initialization
if ! [[ -f "$FILE" ]]; then

    sqlite3 /home/OpenPLC61850/webserver/openplc.db "$SQL_AUTOST"
    
    # in order to make only one initialization
    echo "Don't remove this file" >> /home/OpenPLC61850/started.txt
    
    # query execution
    sqlite3 /home/OpenPLC61850/webserver/openplc.db "$SQL_SCRIPT"

    # setting st file and hardware driver
    sudo rm /home/OpenPLC61850/webserver/active_program
    echo singlesub.st >> /home/OpenPLC61850/webserver/active_program
    
fi 

sudo /home/OpenPLC61850/start_openplc.sh
