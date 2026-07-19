#!/bin/bash

set -e
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.30.3/manifests/calico.yaml

kubectl get nodes -w

echo "======================================"
echo " wait for the node to ready!"
echo "======================================"

kubectl wait --for=condition=Ready node/$(hostname) --timeout=300s

kubectl taint nodes $(hostname) node-role.kubernetes.io/control-plane:NoSchedule-

echo "======================================"
echo " Installing Helm"
echo "======================================"

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helm version