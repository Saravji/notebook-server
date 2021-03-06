#!/bin/bash
cd /tmp
curl -O https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh
bash ./Anaconda3-2020.07-Linux-x86_64.sh
cd ~
source ~/.bashrc
mkdir certificate
mkdir notebook_work
conda install -y -c anaconda gensim tensorflow
conda config --add channels conda-forge
conda install -y -c conda-forge xgboost ipython-autotime lightgbm spacy jupyter_contrib_nbextensions jupyter_nbextensions_configurator boruta_py
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
jupyter contrib nbextension install --user
jupyter nbextensions_configurator enable --user
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
