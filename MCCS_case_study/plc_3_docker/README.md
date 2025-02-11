## Description
A Docker container running a virtual PLC, emulated through OpenPLC. This PLC monitors and controls the sensors and actuators of cylinderC. It receives extension data from a sensor on cylinderC, controls the motor that extends cylinderC, and sends signals to the PLCs controlling cylinderD to initiate their movements.

## Main files description
- config.json: A JSON file containing system information to initialize the PSM broker.
- main.py: A Python program that implements the PSM broker to interact with the Python simulator of the physical process and the virtual PLC3's registers. The PSM (Python SubModule) is an OpenPLC module that enables interaction with external systems, as long as Python drivers exist.
- PLC3.st: A Structured Text (ST) file containing the PLC3's control logic.
- requirements.txt: A text file containing the Python libraries to be installed.
- run.sh: A bash script that initializes and runs OpenPLC.
- comm_modbus.py: A Python script that implements a simple broker, enabling PLC to send signals to the PLC controlling cylinderD via Modbus.
