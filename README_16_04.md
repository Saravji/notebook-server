# notebook-server
script to install jupyter notebook server on base ubuntu server

## original version for ubuntu 16.04 LTS:

after successful deployment of ubuntu and logging into the VM:

### optional: update ubuntu current release:
```
sudo apt update && sudo apt dist-upgrade && sudo apt autoremove
```
a restart might be required after update

### optional: update ubuntu to latest LTS release:
ubuntu update current release pre-requirement.

open the update-manager configuration file and make sure the Prompt line is set to ***lts***
```
sudo nano /etc/update-manager/release-upgrades
```
Confirm that the Prompt is equal _**lts**_:
```
# Default behavior for the release upgrader.

[DEFAULT]
# Default prompting behavior, valid options:
#
#  never  - Never check for a new release.
#  normal - Check to see if a new release is available.  If more than one new
#           release is found, the release upgrader will attempt to upgrade to
#           the release that immediately succeeds the currently-running
#           release.
#  lts    - Check to see if a new LTS release is available.  The upgrader
#           will attempt to upgrade to the first LTS release available after
#           the currently-running one.  Note that this option should not be
#           used if the currently-running release is not itself an LTS
#           release, since in that case the upgrader won't be able to
#           determine if a newer release is available.
Prompt=lts
```

If not, change it to lts and save the file.

and finally initiate the actual upgrade:
(follow the prompts)
```
sudo do-release-upgrade -d
```

### installing notebook server

```
cd $HOME

sudo apt-get install -y git-core

git clone https://github.com/saravji/notebook-server.git
```
if static network is required:
```
    nano ./notebook-server/interfaces_16_04
    source ./notebook-server/stat_network_16_04.sh
```
the main installation script:
```
source ./notebook-server/setup_16_04.sh
```
### optional: Connectivity AZURE Data Warehouse:
if connectivity to AZURE Data warehouse is required execute (this is experimental and might be outdated by now):
```
source ./notebook-server/setup_odbc_16_04.sh
```
