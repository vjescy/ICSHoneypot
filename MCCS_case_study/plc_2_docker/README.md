## Description
A Docker container running a virtual PLC, emulated through OpenPLC. This PLC monitors and controls the sensors and actuators of cylinderB. It receives extension data from a sensor on cylinderB, controls the motor that extends cylinderB, and sends signals to the PLCs controlling cylinderA to initiate their movements.

## Main files description
- config.json: A JSON file containing system information to initialize the PSM broker.
- main.py: A Python program that implements the PSM broker to interact with the Python simulator of the physical process and the virtual PLC2's registers. The PSM (Python SubModule) is an OpenPLC module that enables interaction with external systems, as long as Python drivers exist.
- PLC2.st: A Structured Text (ST) file containing the PLC2's control logic.
- requirements.txt: A text file containing the Python libraries to be installed.
- run.sh: A Bash script that initializes and runs OpenPLC.
- comm_modbus.py: A Python script that implements a simple broker, enabling PLC2 to send signals to the PLC controlling cylinderA via Modbus.
