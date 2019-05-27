kubectl --kubeconfig config run --rm -i -t kube-bench-master --image=aquasec/kube-bench:latest --restart=Never \
--overrides="{ \"apiVersion\": \"v1\", \"spec\": { \"hostPID\": true, \"nodeSelector\": { \"role\": \"master\" }, \"tolerations\": [ { \"key\": \"node-role.kubernetes.io/master\", \"operator\": \"Exists\", \"effect\": \"NoSchedule\" } ] } }" \
-- master --version 1.11