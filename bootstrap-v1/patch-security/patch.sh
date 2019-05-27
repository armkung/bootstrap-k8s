export MASTER_IP=128.199.254.200
export WORKER_IP=178.128.220.68
export MASTER_HOST=tsli-kuber-master-new
export WORKER_HOST=tsli-kuber-worker-new
export DEFAULT_USER=centos

scp -i "key.pem" patch-security/patched-api-server.yaml ${DEFAULT_USER}@${MASTER_IP}:~
ssh -i "key.pem" ${DEFAULT_USER}@${MASTER_IP} -T << EOF
sudo /bin/cp -f ~/patched-api-server.yaml /etc/kubernetes/manifests/kube-apiserver.yaml
sudo systemctl restart kubelet
EOF

scp -i "key.pem" patch-security/patched-controller-manager.yaml ${DEFAULT_USER}@${MASTER_IP}:~
ssh -i "key.pem" ${DEFAULT_USER}@${MASTER_IP} -T << EOF
sudo /bin/cp -f ~/patched-controller-manager.yaml /etc/kubernetes/manifests/kube-controller-manager.yaml
sudo systemctl restart kubelet
EOF

scp -i "key.pem" patch-security/patched-etcd.yaml ${DEFAULT_USER}@${MASTER_IP}:~
ssh -i "key.pem" ${DEFAULT_USER}@${MASTER_IP} -T << EOF
sudo /bin/cp -f ~/patched-etcd.yaml /etc/kubernetes/manifests/etcd.yaml
sudo systemctl restart kubelet
EOF

scp -i "key.pem" patch-security/patched-scheduler.yaml ${DEFAULT_USER}@${MASTER_IP}:~
ssh -i "key.pem" ${DEFAULT_USER}@${MASTER_IP} -T << EOF
sudo /bin/cp -f ~/patched-scheduler.yaml /etc/kubernetes/manifests/kube-scheduler.yaml
sudo systemctl restart kubelet
EOF
