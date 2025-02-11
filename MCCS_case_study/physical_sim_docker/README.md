## Description
A Docker container running a Python physical process simulator, based on the SciPy library, that models the motorized cylinder system in a lightweight manner.

## Main files description
- config.json: A JSON file which contains the data to initialize the simulator, such as udp servers of the external sources (e.g., Python Sub-Module (PSM) brokers of OpenPLC) network info, PLC registers info and the simulation time.
- physics_sim.py: A Python program that simulates the physical process of the system using the SciPy library to solve a system of Ordinary Differential Equations (ODEs);
- requirements.txt: A text file containing the Python libraries to be installed.
- run.sh: A bash script that automatically launches the Python program.

## How to implement a personal simulated physical process
- Modify the config.json file to:
    - Set a desidered simulation time.
    - Set the network info related to the external sources, which inetract with Process Level devices, receiving the simulated values and sending the updated actuators states.
    - Set the input (sensors) and output (actuators) registers of the external sources;
    - Set a desired initial state modifying the input and output registers values. 
- Modify the first-order ODEs system contained in function mydiff() inside physics_sim.py
