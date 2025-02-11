## Description
This folder contains the main files for the simulation.

## Main files description
- extra_config.xml: An XML file which contains the technical info of the various elements involved in the physical process (e.g. generators technical info or cable technical info), the initial state of the circuit breakers and the electrical power demands of the loads;
- pandapower_db_initialization.sql: This SQL file allow the initialization of the tables and entries of the database;
- EPIC_single_substation.ssd: This SSD file is used by the simulator to build the model of the electrical substation;
- Simulator.py: A Python program that simulates the physical process of the system using the Pandapower library and some configuration files to build model.
