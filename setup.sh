#!/bin/bash
cd /tmp
curl -O https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh
bash ./Anaconda3-4.4.0-Linux-x86_64.sh
cd ~
source ~/.bashrc
mkdir certificate
mkdir notebook_work
conda install -y numpy seaborn scipy scikit-learn keras tensorflow
conda update -y conda
conda update -y anaconda
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
read -p "Setting up static ip address? [N|y] " statipflg
if [ $statipflg == 'y' ] || [@statipflg == 'Y' ] 
then
  sudo cp notebook-server/interfaces /etc/network/interfaces
  sudo ip addr flush ens160
  sudo sysmctl restart networking.service
fi
read -p "Need to set up ssh server? [N|y] " sshsrvflg
if [ $sshsrvflg == 'y' ] || [@sshsrvflg == 'Y' ] 
then
  sudo apt-get install openssh-server
  sudo sed -i 's/prohibit-password/yes/' /etc/ssh/sshd_config
  sudo service ssh restart
fi
sudo apt install unzip
sudo apt-get update && sudo apt-get dist-upgrade
