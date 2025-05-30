# lightweight_physical_process_simulators_ICS_honeypot - In this project, there are 2 folders

For details about the way of working of the system, please see the README file inside each of the folder or refer to the original repository.

- First one - scadaBR - contains the environement that contains of PLCs 1,2,3, physical simulator that send data to PLCs and the Human Machine Interface (ScadaBR version). The HMI is configured in a way that allows person (potential malicious actor) to interact with the system by changing the values of High/Low setpoint for every PLC and turning on and off the Pumps and valves. Changes made in HMI are transferred into PLCs.
- Second one - scadaLTS - is exactly the same system, the main difference is that it uses Scada-LTS as a HMI, which is newer version of that HMI. It also uses mySQL database as Scada-LTS requires a database to store its data
## To run the system, 

1. First ensure that docker.io and docker-compose are installed.
2. Move into directory of desired environment, each of the folder contains scripts that are resposnible for managing the system:
   - build_system.sh - shell script that pulls images of each component, builds and configures the system, performs automation (navigating website, imporitng the data, applying changes). **Use this script when running the system for the first time**. After running this script and performing configuration, the system will be restarted and can be accessed in the browser
   - stop_system.sh - used to stop the system, saving the state
   - start_system.sh - reasume working of the system
   - kill_docker.sh - remove all docker containers, networks. **After executing that script, running the system must be done using build_system.sh script**

## Bugs and Fixes

System has been tested on Linux Mint, Lubuntu, Debian and Ubuntu 24.04 (note that in Ubuntu 24.04 some packages are not available via sudo apt tool, so additional mirrors are configured). 
The system works on OS with GUI, while running the system on CLI-based OS (e.g inside WSL), there might appear bugs connected to playwright library accessing the OpenPLC interface via browser.
Sometimes, even on a system with GUI, naviagting the environment and configuring via playwirght might fail. This can happen due to OpenPLCS websites not being loaded, in that case please use the build_system.sh script once again, then it should work.

Sometimes while running the build_system.sh there might appear an error regarding not being able to install some dependencies. Running the script again should resolve that.

## Addressing and Accessing the interface

