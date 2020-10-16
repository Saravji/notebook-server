conda install -c anaconda libgcc
conda install -c anaconda pyodbc
conda install -c anaconda sqlalchemy
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-tools.list
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install mssql-tools
sudo apt-get install unixodbc-dev
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
cp ./notebook-server/pyodbc.py ./anaconda3/pkgs/sqlalchemy-1.1.13-py36_0/lib/python3.6/site-packages/sqlalchemy/dialects/mssql/pyodbc.py
