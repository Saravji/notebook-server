# notebook-server
script to install jupyter notebook server on base ubuntu server

## updated for Ubuntu server 20.04 LTS:

### installing notebook server

after successful deployment of ubuntu and logging into the VM:

```
    git clone https://github.com/saravji/notebook-server.git
```
#### optional: set up static network:

find your network interface:

```
    ip addr
```

there will be a loopback entry and a network address. Find the adapter name. If it is other than "enp0s3", replace "enp0s3" with your adapter entry. There is one locations this needs to happen:  
- in file interfaces, line 3  

update interfaces file to your requires static network configuration:  

```
    nano ./notebook-server/interfaces
    source ./notebook-server/stat_network.sh
```

**This will reboot your server**


the main installation script:

```
    source ./notebook-server/setup.sh
```

on the prompt for the license agreement, go down by pressing [ENTER] repeatedly until you can enter 'yes'  

confirm default installation location  

enter ```yes``` when asked to run conda init  

enter the password you want to set for the jupyter notebook server  

enter certificate information  

enter port number  

adding R kernel prompt  

Finished!


### to-do:

verify odbc connection for Connectivity to AZURE Data Warehouse

## previous versions

- [ubuntu 16.04 LTS + Anaconda3-4.4.0](README_16_04.md)