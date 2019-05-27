helm --kubeconfig config upgrade --wait --install db stable/postgresql \
--version 2.3.3 \
--set postgresqlUsername=admin \
--set postgresqlPassword=1q2w3e4r \
--set postgresqlDatabase=tsli \
--set nodeSelector.role=worker \
--set persistence.storageClass=rook-ceph-fs \
--set persistence.accessModes={ReadWriteMany}