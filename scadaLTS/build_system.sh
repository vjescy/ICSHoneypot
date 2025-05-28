#!/bin/bash

set -e  # Exit on any error
cd "$(dirname "$0")"  # Change to the directory of the script

echo "[+] Updating APT and installing required system packages..."
sudo apt update
sudo apt install -y python3-venv docker.io

echo "[+] Cleaning up old containers..."
sudo docker rm -f plc1_sswat plc2_sswat plc3_sswat sim_sswat 2>/dev/null || true
sudo docker-compose down
echo "[+] Building Docker images..."

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


echo "[+] Running Docker containers..."

docker run -d --name sim_sswat   -p 5502:502 -p 58080:8080 -p 59090:9090 sim_sswat_image
docker run -d --name plc1_sswat -p 2502:502 -p 28080:8080 -p 29090:9090 plc1_sswat_image
docker run -d --name plc2_sswat -p 3502:502 -p 38080:8080 -p 39090:9090 plc2_sswat_image
docker run -d --name plc3_sswat -p 4502:502 -p 48080:8080 -p 49090:9090 plc3_sswat_image

sudo docker-compose up -d

echo "[+] Waiting for containers to initialize..."
sleep 5

echo "[+] Setting up Python virtual environment..."
cd automation

if [ ! -d "venv" ]; then
  echo "[+] Creating virtual environment..."
  python3 -m venv venv || { echo "[✘] Failed to create virtual environment."; exit 1; }
fi

echo "[+] Activating virtual environment..."
source venv/bin/activate

if [ -f "requirements.txt" ]; then
  echo "[+] Installing Python dependencies..."
  pip install --upgrade pip
  pip install -r requirements.txt
fi

# echo "[+] Running setup_import.sh..."
# sudo bash setup_import.sh

# deactivate
# cd ..

# echo "[✔] Build and setup complete."

# echo "[+] Restarting the environment..."
# sudo bash stop_system.sh
# sudo bash start_system.sh

# echo "[✔] Restarting Complete."
