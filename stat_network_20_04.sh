#!/bin/bash
sudo cp notebook-server/interfaces_20_04 /etc/netplan/00-installer-config.yaml
sudo netplan apply
sudo reboot
