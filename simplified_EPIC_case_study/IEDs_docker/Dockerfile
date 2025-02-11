FROM ubuntu:22.04

USER root

WORKDIR /root/
RUN apt-get update && apt-get -y install git sudo mysql-server systemctl nano python3-pip libxml2-utils nlohmann-json3-dev libmysql++-dev openjdk-8-jdk make mininet openvswitch-switch openvswitch-testcontroller xterm jq iproute2 iputils-ping curl dnsutils ifupdown iproute2 iptables iputils-ping mininet net-tools tcpdump x11-xserver-utils gcc g++ && rm -rf /var/lib/apt/lists/* && touch /etc/network/interfaces
RUN sudo ln -s /usr/bin/ovs-testcontroller /usr/bin/controller

WORKDIR /home/
COPY IED ./IED
COPY Mininet ./Mininet
COPY requirements.txt ./requirements.txt
RUN pip3 install -r requirements.txt

# Installing libiec61850
WORKDIR /home/IED/02_build/libs/libiec61850
RUN make

# Building IEDs
WORKDIR /home/IED/
RUN ./ied_build.sh

WORKDIR /home/Mininet
COPY run.sh ./

CMD ["./run.sh"]
