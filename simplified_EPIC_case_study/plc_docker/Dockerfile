FROM ubuntu:22.04

USER root
WORKDIR /root/
RUN apt-get update && \
    apt-get -y install git sudo

WORKDIR /home/
RUN git clone https://github.com/smartgridadsc/OpenPLC61850.git


WORKDIR /home/OpenPLC61850/
# Installing OpenPLCIEC61850
RUN sudo ./install.sh linux
# Configuring OpenPLCIEC61850
RUN sudo rm -r ./webserver/st_files
RUN sudo rm -r ./webserver/scl_client_files
RUN sudo rm -r ./webserver/scl_server_files
COPY st_files ./webserver/st_files
COPY scl_client_files ./webserver/scl_client_files
COPY scl_server_files ./webserver/scl_server_files
COPY run.sh ./
#give permission to run.sh
RUN chmod +x run.sh

EXPOSE 502
EXPOSE 8080
# IEC61850
EXPOSE 102 

CMD ["./run.sh"]
