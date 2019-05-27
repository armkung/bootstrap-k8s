# Centos cluster

## Prerequisites
- ssh client
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-binary-using-curl)
- [helm(2.10.0)](https://github.com/helm/helm/releases/tag/v2.10.0)
- [ansible](https://docs.ansible.com/ansible/2.5/installation_guide/intro_installation.html#installing-the-control-machine)

## How to bootstrap cluster
```
ansible-playbook ansible/bootstrap.yaml -i env/dev/hosts.ini
```

## How to clean up
```
ansible-playbook ansible/cleanup.yaml -i env/dev/hosts.ini
```

## Inbound rules
### Master node
```
Protocol    Port        Source          Description
TCP         22          0.0.0.0/0       SSH
TCP         80          0.0.0.0/0       http
TCP         443         0.0.0.0/0       https
TCP         6443        0.0.0.0/0       k8s api server
TCP         10250       10.0.0.0/8      kubelet
TCP         10251       10.0.0.0/8      kube-scheduler
TCP         10252       10.0.0.0/8      kube-controller-manager
TCP         10256       10.0.0.0/8      kube-proxy
TCP         9099        10.0.0.0/8      calico-felix
TCP         9100        10.0.0.0/8      node-exporter
TCP         179         10.0.0.0/8      BGP
TCP         2379-2380   10.0.0.0/8      etcd server
UDP         4789        10.0.0.0/8      flannel
UDP         8472        10.0.0.0/8      flannel vxlan backend
UDP         8285        10.0.0.0/8      flannel udp backend
TCP         30000-32767 10.0.0.0/8      k8s node port
```

### Worker node
```
Protocol    Port        Source          Description
TCP         22          0.0.0.0/0       SSH
TCP         10250       10.0.0.0/8      kubelet
TCP         10256       10.0.0.0/8      kube-proxy
TCP         9099        10.0.0.0/8      calico-felix
TCP         9100        10.0.0.0/8      node-exporter
TCP         179         10.0.0.0/8      BGP
TCP         2379-2380   10.0.0.0/8      etcd server
UDP         4789        10.0.0.0/8      flannel
UDP         8472        10.0.0.0/8      flannel vxlan backend
UDP         8285        10.0.0.0/8      flannel udp backend
TCP         30000-32767 10.0.0.0/8      k8s node port
```