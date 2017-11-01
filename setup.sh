#!/bin/bash
cd /tmp
curl -O https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh
bash ./Anaconda3-4.4.0-Linux-x86_64.sh
cd ~
echo "PATH=/home/$USER/anaconda3:$PATH" >>~/.bash_profile
echo "PATH=/home/$USER/anaconda3/bin:$PATH" >> ~/.bash_profile 
source ~/.bashrc
mkdir certificate
mkdir notebook_work
conda install -y numpy seaborn scipy scikit-learn keras tensorflow
conda install -y -c conda-forge xgboost
conda update -y conda
conda update -y anaconda
conda update -y notebook
jupyter notebook --generate-config
jupyter notebook password
openssl req -x509 -nodes -days 3650 -newkey rsa:1024 -keyout ./certificate/mykey.key -out ./certificate/mycert.pem 
echo "c.NotebookApp.certfile = u'/home/$USER/certificate/mycert.pem'" >> ./.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.keyfile = u'/home/$USER/certificate/mykey.key'" >> ./.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'" >> ./.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.notebook_dir = u'/home/$USER/notebook_work'" >> ./.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> ./.jupyter/jupyter_notebook_config.py
read -p "Which port shall jupyter notebook be available on? " port
echo "c.NotebookApp.port = $port" >> ./.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.password_required = False" >> ./.jupyter/jupyter_notebook_config.py
pwd=$(cat ./.jupyter/jupyter_notebook_config.json | sed -n -e 's/^.*"password": //p' | sed 's/[^"]*"\([^"]*\)".*/\1/')
echo "c.NotebookApp.password = u'$pwd'" >> ./.jupyter/jupyter_notebook_config.py
while true; do
    read -p "Setting up static ip address? [N|y] " -i 'N' statipflg
    case $statipflg in
        [Yy]* ) 
          sudo cp notebook-server/interfaces /etc/network/interfaces
          sudo ip addr flush ens160
          sudo systemctl restart networking.service;
          break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Need to set up ssh server? [N|y] " -i 'N' sshsrvflg
    case $sshsrvflg in
        [Yy]* ) 
          sudo apt-get install openssh-server
          sudo sed -i 's/prohibit-password/yes/' /etc/ssh/sshd_config
          sudo service ssh restart;
          break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Want to add R kernel? [N|y] " -i 'N' rkernelflg
    case $rkernelflg in
        [Yy]* ) 
          conda install -c r r-essentials;
          break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
sudo apt-get install unzip zip
sudo apt-get update && sudo apt-get dist-upgrade
