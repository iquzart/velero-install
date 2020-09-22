# Install Velero on AKS Cluster

Bash script to install and configure Velero Server and Client for AKS Cluster

# Features
```
1. Download and set velero client
2. Configure veleor secret file
3. Install velero with storage account access key and no Azure snapshots
```

# Variables
```
VELERO_VERSION=v1.5.1
VELERO_SECRET_FILE=credentials-velero
BLOB_CONTAINER=example_container
AZURE_BACKUP_RESOURCE_GROUP=example_backup_rg
AZURE_STORAGE_ACCOUNT_ID=example_storage_account
AZURE_STORAGE_ACCOUNT_ACCESS_KEY=example_access_key
```

