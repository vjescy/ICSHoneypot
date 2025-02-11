## Description
A Docker container running a virtual PLC, emulated using OpenPLC. This PLC monitors and controls the sensors and actuators of cylinderD. It receives extension data from a sensor on cylinderD, controls the motor that extends cylinderD, and sends signals to the PLCs controlling cylinderB and cylinderC to initiate their movements.

## Main files description
- config.json: A JSON file containing system information to initialize the PSM broker.
- main.py: A Python program that implements the PSM broker to interact with the Python simulator of the physical process and the virtual PLC4's registers. The PSM (Python SubModule) is an OpenPLC module that enables interaction with external systems, as long as Python drivers exist.
- PLC4.st: A Structured Text (ST) file containing the PLC4's control logic.
- requirements.txt: A text file containing the Python libraries to be installed.
- run.sh: A Bash script that initializes and runs OpenPLC.
- comm_modbus.py: A Python script that implements a simple broker, enabling PLC4 to send signals to the PLCs controlling cylinderB and cylinderC via Modbus.
