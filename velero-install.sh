VELERO_VERSION=v1.5.1
VELERO_SECRET_FILE=credentials-velero
BLOB_CONTAINER=example_container
AZURE_BACKUP_RESOURCE_GROUP=example_backup_rg
AZURE_STORAGE_ACCOUNT_ID=example_storage_account
AZURE_STORAGE_ACCOUNT_ACCESS_KEY=example_access_key

echo "Downloading Velero version $VELERO_VERSION"
wget -q --show-progress  https://github.com/vmware-tanzu/velero/releases/download/$VELERO_VERSION/velero-$VELERO_VERSION-linux-amd64.tar.gz -P /tmp

echo "Copying Velero Binary to /usr/local/sbin"
tar -xf /tmp/velero-$VELERO_VERSION-linux-amd64.tar.gz --directory /tmp
cp -p /tmp/velero-$VELERO_VERSION-linux-amd64/velero /usr/local/sbin/

echo "Creating secret-file credentials-velero"
echo "AZURE_STORAGE_ACCOUNT_ACCESS_KEY=$AZURE_STORAGE_ACCOUNT_ACCESS_KEY" | tee -a $VELERO_SECRET_FILE > /dev/null
echo "AZURE_CLOUD_NAME=AzurePublicCloud"                                  | tee -a $VELERO_SECRET_FILE > /dev/null


echo "Installing Velero on AKS"
echo "velero install \
    --velero-pod-cpu-request 1m \
    --velero-pod-mem-request 256Mi \
    --velero-pod-cpu-limit 1 \
    --velero-pod-mem-limit 1Gi \
    --provider azure \
    --plugins velero/velero-plugin-for-microsoft-azure:master \
    --bucket $BLOB_CONTAINER \
    --secret-file ./credentials-velero \
    --backup-location-config resourceGroup=$AZURE_BACKUP_RESOURCE_GROUP,storageAccount=$AZURE_STORAGE_ACCOUNT_ID,storageAccountKeyEnvVar=AZURE_STORAGE_ACCOUNT_ACCESS_KEY \
    --use-volume-snapshots=false"
