conda install libgcc version=5.2.0
conda install pyodbc version=4.0.17
conda install sqlalchemy version=1.1.13
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-tools.list
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install mssql-tools
sudo apt-get install unixodbc-dev
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
cp ./notebook-server/pyodbc.py ./anaconda3/pkgs/sqlalchemy-1.1.13-py36_0/lib/python3.6/site-packages/sqlalchemy/dialects/mssql/pyodbc.py
