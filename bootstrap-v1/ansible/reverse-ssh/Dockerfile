FROM ubuntu:18.04

ENV DOMAIN appman.co.th

COPY serveo /usr/local/bin

COPY rsa_key /root/.ssh/id_rsa
COPY rsa_key.pub /root/.ssh/id_rsa.pub

EXPOSE 2222 80 443

ENTRYPOINT serveo -private_key_path=/root/.ssh/id_rsa -disable_telemetry -port=2222 -http_port=80 -https_port=443 -domain=$DOMAIN