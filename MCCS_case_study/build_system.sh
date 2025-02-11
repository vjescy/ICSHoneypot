#!bin/bash/

# Building docker images
cd ./scada_hmi_docker/
docker build ./ -t scada_hmi_mccs_image
cd ..

cd ./physical_sim_docker/
docker build ./ -t sim_mccs_image
cd ..

cd ./plc_1_docker/
docker build ./ -t plc1_mccs_image
cd ..

cd ./plc_2_docker/
docker build ./ -t plc2_mccs_image
cd ..

cd ./plc_3_docker/
docker build ./ -t plc3_mccs_image
cd ..

cd ./plc_4_docker/
docker build ./ -t plc4_mccs_image
cd ..

# Running docker containers
docker run -d --name scada_hmi_mccs -p 1502:502 -p 18080:8080 -p 19090:9090 scada_hmi_mccs_image
docker run -d --name plc1_mccs -p 2502:502 -p 28080:8080 -p 29090:9090 plc1_mccs_image
docker run -d --name plc2_mccs -p 3502:502 -p 38080:8080 -p 39090:9090 plc2_mccs_image
docker run -d --name plc3_mccs -p 4502:502 -p 48080:8080 -p 49090:9090 plc3_mccs_image
docker run -d --name plc4_mccs -p 5502:502 -p 58080:8080 -p 59090:9090 plc4_mccs_image
docker run -d --name sim_mccs -p 6502:502 -p 680:8080 -p 690:9090 sim_mccs_image
