#!bin/bash/

# Define the bindings
binding="172.17.0.4 plc.rete"

# Store the hosts file location
hosts_file="/etc/hosts"

# restarting webserver
sudo /opt/tomcat6/apache-tomcat-6.0.53/bin/shutdown.sh
sudo /opt/tomcat6/apache-tomcat-6.0.53/bin/startup.sh

FILE=/home/ScadaBR_Installer/started.txt
if ! [[ -f "$FILE" ]]; then

    echo "Don't remove this file" >> /home/ScadaBR_Installer/started.txt
    
    # hosts initialization
    # Check if the hosts file exists
    if [ -f "$hosts_file" ]; then
        # Backup the original hosts file
	sudo cp "$hosts_file" "${hosts_file}.bak"

        # Add the bindings to the hosts file
        sudo echo "$binding" >> "$hosts_file"

        echo "Hosts file updated successfully."
    else
        echo "Error: Hosts file not found."
    fi
     
    sudo python3 loaddata.py
     
fi 
    
#make the container run infinitely 
tail -f "/dev/null"
