# kubernetes-for-china

## Kubernetes Install

- [install kubeadm](https://kubernetes.io/docs/setup/independent/install-kubeadm/)

1. Install Docker

- [Get Docker CE for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

```bash
$ curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
```

2. Installing kubeadm, kubelet and kubectl 

- [Kubernetes mirror](https://opsx.alibaba.com/mirror)

```bash
apt-get update && apt-get install -y apt-transport-https
curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
```

3. Preload Kubernetes images form Alibaba Cloud Registry Service

- [gcr.io images mirror on aliyun](https://dev.aliyun.com/list.html?namePrefix=google-containers)

```bash
$ ./load_images.sh
$ docker pull quay.io/coreos/flannel:v0.9.1-amd64
```

4. Create a Cluster
```bash
$ sudo kubeadm init --pod-network-cidr=10.244.0.0/16
$ kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.9.1/Documentation/kube-flannel.yml

# Master Isolation (if single-machine Kubernetes cluster )
$ kubectl taint nodes --all node-role.kubernetes.io/master-
```

## [Helm](https://github.com/kubernetes/helm)


```bash
# install
$ curl -s https://storage.googleapis.com/kubernetes-helm/helm-v2.8.2-linux-amd64.tar.gz | tar xzv
$ sudo cp linux-amd64/helm /usr/local/bin
$ rm -rf linux-amd64

# initialize the local CLI and also install Tiller into your Kubernetes cluster
$ helm init

# update charts repo
$ helm repo update

# install mysql chart
$ helm install --name my_mysql stable/mysql

# delete
$ helm delete my_mysql

# remove the release from the store and make its name free for later use
$ helm delete --purge my_mysql
```


## [Draft](https://github.com/Azure/draft)

```bash

# install
$ curl -s https://azuredraft.blob.core.windows.net/draft/draft-canary-linux-amd64.tar.gz | tar xzv
$ sudo cp linux-amd64/draft /usr/local/bin
$ rm -rf linux-amd64

# initialize
$ draft init

# demo usage

$ git clone https://github.com/maguowei/draft-django-demo.git
$ cd draft-django-demo
$ draft up
```