#!/bin/bash
sudo cp notebook-server/interfaces /etc/netplan/00-installer-config.yaml
sudo netplan apply
sudo reboot
