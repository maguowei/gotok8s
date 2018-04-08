# kubernetes-for-china


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