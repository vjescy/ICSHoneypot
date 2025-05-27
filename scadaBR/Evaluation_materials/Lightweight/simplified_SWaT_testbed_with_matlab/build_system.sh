#!bin/bash/

# Building docker images
cd ./scada_hmi_docker/
docker build ./ -t scada_hmi_sswat_mlab_image
cd ..

cd ./plc_1_docker/
docker build ./ -t plc1_sswat_mlab_image
cd ..

cd ./plc_2_docker/
docker build ./ -t plc2_sswat_mlab_image
cd ..

cd ./plc_3_docker/
docker build ./ -t plc3_sswat_mlab_image
cd ..

# Running docker containers
docker run -d --name scada_hmi_sswat_mlab -p 1502:502 -p 18080:8080 -p 19090:9090 scada_hmi_sswat_mlab_image
docker run -d --name plc1_sswat_mlab -p 2502:502 -p 28080:8080 -p 29090:9090 plc1_sswat_mlab_image
docker run -d --name plc2_sswat_mlab -p 3502:502 -p 38080:8080 -p 39090:9090 plc2_sswat_mlab_image
docker run -d --name plc3_sswat_mlab -p 4502:502 -p 48080:8080 -p 49090:9090 plc3_sswat_mlab_image
