# notebook-server
script to install jupyter notebook server on base ubuntu server

after successful deployment of ubuntu and logging into the VM execute:
```
cd $HOME

sudo apt-get install -y git-core

git clone https://github.com/saravji/notebook-server.git
```
if static network is required:
```
    nano ./notebook-server/interfaces

source ./notebook-server/setup.sh
```
if connectivity to AZURE Data warehouse is required execute:
```
source ./notebook-server/setup_odbc.sh
```
