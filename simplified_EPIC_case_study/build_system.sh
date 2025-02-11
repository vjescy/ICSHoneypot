#!bin/bash/

# Building docker images
cd ./scada_hmi_docker/
docker build ./ -t scada_hmi_sepic_image
cd ..

cd ./IEDs_docker/
docker build ./ -t ieds_sepic_image
cd ..

cd ./physical_sim_docker/
docker build ./ -t sim_sepic_image
cd ..

cd ./plc_docker/
docker build ./ -t plc_sepic_image
cd ..

# Running docker containers
docker run -d --name ieds_sepic --privileged -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /lib/modules:/lib/modules ieds_sepic_image
docker run -d --name sim_sepic sim_sepic_image
docker run -d --name plc_sepic -p 2502:502 -p 28080:8080 -p 2102:102 plc_sepic_image
docker run -d --name scada_hmi_sepic -p 1502:502 -p 18080:8080 -p 19090:9090 scada_hmi_sepic_image

