#!/bin/bash
sudo cp notebook-server/interfaces /etc/network/interfaces
sudo ip addr flush ens160
sudo systemctl restart networking.service;
