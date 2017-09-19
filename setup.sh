#!/bin/bash
cd /tmp
curl -O https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh
bash ./Anaconda3-4.4.0-Linux-x86_64.sh
cd ~
source ~/.bashrc
./notebook-server/setup2.sh
