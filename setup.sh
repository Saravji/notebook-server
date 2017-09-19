cd /tmp
curl -O https://repo.continuum.io/archive/Anaconda3-4.4.0.1-Linux-ppc64le.sh
bash Anaconda3-4.4.0.1-Linux-ppc64le.sh
source ~/.bashrc
cd ~
mkdir certificate
conda create --name kaggle_env python=3
conda install --name kaggle_env numpy seaborn scipy scikit-learn keras tensorflow
conda update conda
conda update anaconda
jupyter notebook --generate-config
jupyter notebook password
jupyter notebook --certfile=mycert.pem --keyfile mykey.key
openssl req -x509 -nodes -days 3650 -newkey rsa:1024 -keyout mykey.key -out mycert.pem 
echo "c.NotebookApp.certfile = u'/home/$USER/certificate/mycert.pem'" >> ./.jupyter_notebook_config.py
echo "c.NotebookApp.keyfile = u'/home/$USER/certificate/mykey.key'" >> ./.jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'" >> ./.jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> ./.jupyter_notebook_config.py
echo "c.NotebookApp.port = 8890" >> ./.jupyter_notebook_config.py
echo "c.NotebookApp.password_required = True" >> ./.jupyter_notebook_config.py
echo "c.NotebookApp.password = u'sha1:'" >> ./.jupyter_notebook_config.py
