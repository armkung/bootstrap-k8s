sshuttle --dns -HNr appman@tsli 0/0

ssh -R tsli-uat-worker:2222:localhost:22 -p 32022 178.128.220.68
sudo cat > /etc/systemd/system/ingress.service << EOF
[Unit] 
Description=Keep a tunnel to open 
After=network-online.target

[Service] 
ExecStart=/bin/autossh -M 0 -N \
          -o "ExitOnForwardFailure=yes" \
          -o "ServerAliveInterval 5" \
          -o "ServerAliveCountMax 1" \
          -R tsli-uat-worker:2222:localhost:22 \
          -p 32022 178.128.220.68
ExecStop=/usr/bin/pkill autossh
Restart = always
[Install] 
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo service ingress start
sudo systemctl enable ingress

ceph config set mgr mgr/prometheus/server_addr 0.0.0.0
ceph mgr module disable prometheus
ceph mgr module enable prometheus

ceph config set mgr mgr/dashboard/a/server_addr 0.0.0.0
ceph dashboard set-login-credentials admin 1q2w3e4r
ceph mgr module disable dashboard
ceph mgr module enable dashboard

mc config host add myminio http://minio:9000 OA0A3308VQ2QNQ70MTWF tlgmd5idweGiY4S3TeozQNkX6Wo6EP1QlQ2ewWNl 
mc event add myminio/tsli-documents arn:minio:sqs:us-east-1:1:elasticsearch

docker save $(docker images | grep -E 'prom|metrics|exporter|grafana' | awk '{print $1 ":" $2 }') -o monitor.tar