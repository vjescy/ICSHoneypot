
# SWAT system honeynet with a python physics simuator

## Description

This honeynet is a simplified version of the Secure Water Treatment (SWaT) testbed, originally developed by iTrust. 

The honeynet comprises:
- Three Virtual PLCs: Simulated using OpenPLC, these PLCs monitor sensors and control actuators within the simulated tanks system;
- An HMI: Implemented with ScadaBR, this HMI allows users to visualize and interact with the simulated process;
- A Python Physical Simulator: Using the SciPy module and first-order differential equations, this simulator models the physical processes occurring in the water treatment tanks system;
- A Phyton broker: A broker which simulates the comunication between two plcs (plc1 and plc2).

![HMI's view of the system]()

## Communication architecture between phyton physical simulator and OpenPLCs

## Main file descriptions
- build_system.sh: A bash script that builds docker images and runs the docker containers of the system (plcs, hmi and python simulator).
- start_system.sh: A bash script that starts docker containers of the system.
- stop_system.sh: A bash script that stops docker containers of the system.

## Docker images building and containers running

```bash
  sh ./build_system.sh
```

## Starting the system

```bash
  sh ./starting_system.sh
```

## Important note
Due to a problem with the code of snap7 server, when you try to start the server and then detach the container, the server will stop. So, you have to do these operations for each PLC.
1) Open a prompt inside PLC's container
```bash
  docker exec -it plc1_swat bash
```
2) Start the snap7 server
```bash
  sudo /home/honeyplc/snap7/examples/cpp/x86_64-linux/server 0.0.0.0
```
3) Close the prompt window (click on X)

## Important note
When you start the system for the first time you have to click on "Save changes" button in the "Hardware" page for each OpenPLC istance. Then you have to restart the system.
