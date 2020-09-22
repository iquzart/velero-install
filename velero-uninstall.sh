echo "Deleting namespace and CRBs related to Velero"
kubectl delete namespace/velero clusterrolebinding/velero
echo "Deleting CRDs related to Velero"
kubectl delete crds -l component=velero
