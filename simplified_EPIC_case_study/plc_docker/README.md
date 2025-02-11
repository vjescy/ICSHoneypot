## Description
A Docker container running a virtual PLC, emulated using OpenPLC61850, which receives data from the IEDs and sends these data to the SCADA HMI.

## Main folders and files description
- st_files: This folder contains the PLC's control logic as Structured Text (ST) file;
- scl_server_files: This folder contains the icd file to instance the IEC61850 server;
- scl_client_files: This folder contains the icd files of each IED to instance the IEC61850 clients;
- run.sh: A bash script that initializes and runs OpenPLC.
