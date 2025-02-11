#!/bin/bash

service openvswitch-switch start

python3 ./run.py &

tail -f "/dev/null"
