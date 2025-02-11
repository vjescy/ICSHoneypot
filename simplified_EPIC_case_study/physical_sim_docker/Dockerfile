FROM ubuntu:22.04

USER root
WORKDIR /root/
RUN apt-get update && \
    apt-get -y install mysql-server python3 python3-pip python3-venv

# To allow external connections to mysql
COPY mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

WORKDIR /home/
COPY Panda-db ./Panda-db
COPY mysql_initialization.sql ./
COPY requirements.txt ./
COPY run.sh ./
# To give permission to run.sh
RUN chmod +x run.sh

# To create a python venv
RUN python3 -m venv .venv
RUN .venv/bin/pip3 install -r requirements.txt

WORKDIR /home/

# For mysql service
EXPOSE 3306

CMD ["sh", "run.sh"]
#CMD ["tail", "-f", "/dev/null"]
