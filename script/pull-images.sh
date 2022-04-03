#!/usr/bin/env bash

# 确保关闭交换空间(running with swap on is not supported. Please disable swap)
sudo swapoff -a
# 永久关闭需要编辑 `/etc/fstab` 注释掉 `swap` 所在行

# 获取最新 Kubernetes 版本号
KUBERNETES_RELEASE_VERSION="$(curl -sSL https://dl.k8s.io/release/stable.txt)"

# 可以用下面的命令列出 kubeadm 需要的 images
kubeadm config images list --kubernetes-version=${KUBERNETES_RELEASE_VERSION}
# 提前拉取所需的镜像
docker pull gotok8s/coredns:v1.8.6 && docker tag gotok8s/coredns:v1.8.6 gotok8s/coredns/coredns:v1.8.6
kubeadm config images pull --config init.yml
