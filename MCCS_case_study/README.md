# Motorized Cylinder Control System (MCCS) testbed with a Python physical process simulator

## Description
This testbed has been specifically designed to evaluate a SciPy-based physical process simulator, developed to replace the heavyweight MATLAB Simulink simulator within the HoneyICS honeynet, created by Marco Lucchese et al. It replicates an Industrial Control System (ICS) up to the Supervisory level of the Purdue model for a four-cylinder motorized system. The architecture, technologies, and tools of this testbed are inspired by the HoneyICS honeynet. The main purpose of this testbed is to assess the SciPy-based simulator in a context where PLC synchronization is crucial. The implemented physical process is based on the Pneumatic Control System (PCS) testbed developed by Fereidoun Moradi et al., which involves two pneumatic cylinders that move an object from an initial position (X) to a final position (Y). In contrast, the physical process of the MCCS testbed consists of four motorized cylinders, each controlled by a dedicated PLC. These cylinders move an object from an initial position (X) to a final position (Z), passing through an intermediate position (Y).

This testbed consists of six Docker containers:
- SCADA HMI container: This container runs an instance of ScadaBR, which implements a SCADA HMI, allowing users to visualize and interact with the physical process.
- Four Virtual PLC containers: Each container runs a virtual PLC implemented using OpenPLC. These PLCs monitor sensors and control actuators within the simulated motorized cylinder system. Additionally, every PLC container includes a Python broker to simulate communication with other PLCs.
- Physical process simulator container: This container runs a Python physical process simulator that uses the SciPy library and first-order differential equations to model the physical processes occurring in the motorized cylinder system.

## Physical process
The physical process involves four pneumatic cylinders (cylinderA, cylinderB, cylinderC, and cylinderD) tasked with moving objects from an initial position (X) to a final position (Z), passing through an intermediate position (Y).

The process steps are as follows:
1) CylinderB picks up an object from position X.
2) CylinderA pushes CylinderB to the right until it reaches position Y.
3) CylinderB places the object at the intermediate position (Y).
4) CylinderA returns CylinderB to its initial position (X).
5) CylinderC pushes CylinderD to the left until it reaches position Y.
6) CylinderD picks up the object from position Y.
7) CylinderC returns CylinderD to its initial position (Z).
8) CylinderD places the object at the final position (Z).
9) The process then repeats from step 1.

## Testbed architecture
![arch_mccs](/materials/images/architecture_MCCS_testbed_scipy.png)
**Figure 1**: Motorized cylinder control system testbed architecture

## SciPy-based physical process simulator interactivity property evaluation
To evaluate the interactivity property of the SciPy-based simulator, a Python script has been developed. This script connects via Modbus to PLC-2, which controls Cylinder B, and continuously overwrites the register responsible for system synchronization, forcing the cylinder’s motor to stay active. This Python script is contained inside "/Evaluation_materials/Interactivity". **Figure 2** shows the normal operation of the cylinder, with the correct operation frequency, while **Figure 3** shows the physical process manipulation caused by the Python script.

![gen_cyl_b](/materials/images/genuine_cylinder_B.png)
**Figure 2**: Genuine physical process Cylinder B
![man_cyl_b](/materials/images/manipulated_cylinder_B.png)
**Figure 3**: Manipulated physical process Cylinder B

## SciPy-based physical process simulator lightweight property evaluation
**Figure 4** shows the RAM and CPU consumption of the SciPy-based physical process simulator of the MCCS testbed.

![man_cyl_b](/materials/images/manipulated_cylinder_B.png)
**Figure 4**: MCCS SciPy-based physical process simulator consumed resources

## Main file descriptions
- build_system.sh: A bash script that builds docker images and runs the docker containers of the system (PLCs, SCADA HMI and SciPy-based simulator).
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

## Stopping the system

```bash
  sh ./stop_system.sh
```

## Important note about OpenPLC instances
When you start the system for the first time you have to click on "Save changes" button in the "Hardware" page for each OpenPLC istance. Then you have to restart the system.
