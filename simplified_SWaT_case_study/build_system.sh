#!/bin/bash

set -e  # Stop on error
cd "$(dirname "$0")"  # Run from script's directory

echo "[+] Cleaning up old containers..."
sudo docker rm -f scada_hmi_sswat plc1_sswat plc2_sswat plc3_sswat sim_sswat 2>/dev/null || true

echo "[+] Building docker images..."
cd ./scada_hmi_docker/
docker build ./ -t scada_hmi_sswat_image
cd ..

cd ./physical_sim_docker/
docker build ./ -t sim_sswat_image
cd ..

cd ./plc_1_docker/
docker build ./ -t plc1_sswat_image
cd ..

cd ./plc_2_docker/
docker build ./ -t plc2_sswat_image
cd ..

cd ./plc_3_docker/
docker build ./ -t plc3_sswat_image
cd ..

echo "[+] Running docker containers..."
docker run -d --name scada_hmi_sswat -p 1502:502 -p 18080:8080 -p 19090:9090 scada_hmi_sswat_image
docker run -d --name plc1_sswat -p 2502:502 -p 28080:8080 -p 29090:9090 plc1_sswat_image
docker run -d --name plc2_sswat -p 3502:502 -p 38080:8080 -p 39090:9090 plc2_sswat_image
docker run -d --name plc3_sswat -p 4502:502 -p 48080:8080 -p 49090:9090 plc3_sswat_image
docker run -d --name sim_sswat   -p 5502:502 -p 58080:8080 -p 59090:9090 sim_sswat_image

echo "[+] Waiting for containers to initialize..."
sleep 5

echo "[+] Running automation/setup_import.py..."
cd automation
source venv/bin/activate
sudo bash setup_import.sh
deactivate
cd ..

echo "[✔] Build and setup complete."

echo "[+] Restarting the environment."

sudo bash stop_system.sh
sudo bash start_system.sh

echo "[✔] Restarting Complete."