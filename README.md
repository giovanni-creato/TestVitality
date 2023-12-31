# **Git-Endevor mapping**
### Overview 

This repository was initialized using [CA Endevor Bridge for Git](http://techdocs.broadcom.com/content/broadcom/techdocs/us/en/ca-mainframe-software/devops/ca-endevor-integrations-for-enterprise-devops/1-0/ca-endevor-bridge-for-git.html).
Following branches are synchronized with CA Endevor:

* main  

**[Endevor inventory details](./docs/inventory.md)**  
**[Types and processor groups list](./docs/types.md)**

To know more about CA Endevor Bridge for Git and how to use it, check the page [Use the CA Endevor Bridge for Git](https://techdocs.broadcom.com/us/en/ca-mainframe-software/devops/ca-endevor-integrations-for-enterprise-devops/1-0/ca-endevor-bridge-for-git/Using-ca-enterprise-git-bridge.html).

### Install Pre-push hook locally

If you do not have the server pre-receive hook enabled, you need to use the local pre-push hook. You can install the hook in one of two ways:

1. Run the script [scripts/setup.sh](scripts/setup.sh).
<br/>OR
2. Copy manually the [pre-push](scripts/resources/pre-push) script into the hidden `.git/hooks` folder. 

### Work Areas

To update information about the Work Areas for this repository, consult the provided [work-areas.json](.ebg/work-areas.json) 
template in the [official documentation](https://techdocs.broadcom.com/us/en/ca-mainframe-software/devops/ca-endevor-integrations-for-enterprise-devops/1-0/ca-endevor-bridge-for-git/Using-ca-enterprise-git-bridge/mapping-administration/optional-configure-and-commit-workareas-file.html).
