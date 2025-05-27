FROM ubuntu:22.04

USER root
WORKDIR /root/
RUN apt-get update && \
    apt-get -y install git sudo

WORKDIR /home/
RUN git clone https://github.com/thiagoralves/OpenPLC_v3.git

WORKDIR /home/OpenPLC_v3/
# Stable version of OpenPLC commit:a283d0dbac813116babdf81c53144c4d455edf49 (dec 2023)
RUN git checkout 8fc7292f305c9cf302e40b1c1b11bfd7eaa95842
RUN sudo ./install.sh linux

# copy files into docker container
COPY run.sh ./
#give permission to run.sh
RUN chmod +x run.sh
COPY PLC1.st scripts/
COPY PLC1.st.dbg scripts/

# lighttpd and snap7
WORKDIR /home/
RUN apt-get update && \
    apt-get -y install lighttpd
RUN git clone https://github.com/sefcom/honeyplc.git
COPY ./web /var/www/html
COPY lighthttpd.conf /etc/lighttpd/lighttpd.conf
RUN cd /home/honeyplc/snap7/build/bin/x86_64-linux/ && cp libsnap7.so-1200 /usr/lib/libsnap7.so

WORKDIR /home/OpenPLC_v3/

EXPOSE 502
EXPOSE 8080
EXPOSE 102
EXPOSE 80

CMD ["./run.sh"]
#CMD ["tail", "-f", "/dev/null"]
