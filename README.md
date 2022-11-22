# Goto Kubernetes

[![github workflow](https://github.com/gotok8s/gotok8s/workflows/k8s%20image%20sync/badge.svg)](https://github.com/gotok8s/gotok8s/actions)

## 安装 `Kubernetes`

> 对于 `Mac` 用户可以参考:  [k8s-docker-desktop-for-mac](https://github.com/maguowei/k8s-docker-desktop-for-mac), 
通过 `Docker Desktop for Mac` 开启和使用 Kubernetes

1. [安装Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

```bash
$ curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
```

2. [安装 kubeadm, kubelet and kubectl](https://kubernetes.io/docs/setup/independent/install-kubeadm/)

    - [Alibaba Kubernetes mirror](https://opsx.alibaba.com/mirror)

```bash
# Debian/Ubuntu
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list


sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

3. 使用 `kubeadm` 创建 `Kubernetes` 集群

```bash
# 获取最新 Kubernetes 版本号
$ KUBERNETES_RELEASE_VERSION="$(curl -sSL https://dl.k8s.io/release/stable.txt)"

# 可以用下面的命令列出 kubeadm 需要的 images
$ kubeadm config images list --kubernetes-version=${KUBERNETES_RELEASE_VERSION}
# 提前拉取所需的镜像
$ sudo kubeadm config images pull --config init.yml

# 集群初始化（init.yml文件中配置了使用阿里的镜像仓库）
$ sudo kubeadm init --config init.yml
# 或者执行(忽略Docker版本检查)
$ sudo kubeadm init --config init.yml --ignore-preflight-errors=SystemVerification

# KUBECONFIG 设置
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 使用 `flannel` 网络
$ kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Master Isolation (if single-machine Kubernetes cluster )
$ kubectl taint nodes --all node-role.kubernetes.io/master-
```

## [Kubernetes Dashboard](https://github.com/kubernetes/dashboard)

### 部署 Kubernetes Dashboard

```bash
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended.yaml

# 开启本机访问代理
$ kubectl proxy
```

### 创建`Dashboard`管理员用户并用`token`登陆

```bash
# 创建 ServiceAccount kubernetes-dashboard-admin 并绑定集群管理员权限
$ kubectl apply -f https://raw.githubusercontent.com/gotok8s/gotok8s/master/dashboard-admin.yaml

# 获取登陆 token
$ kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep kubernetes-dashboard-admin | awk '{print $1}')
```

通过下面的连接访问 Dashboard: [http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/)

输入上一步获取的token, 验证并登陆。

## [Helm](https://github.com/kubernetes/helm)

### 安装

详细使用说明请参考 [`Helm`官方文档](https://v3.helm.sh/docs/)

```bash
# Linux 用户
$ curl -s https://get.helm.sh/helm-v3.8.1-linux-amd64.tar.gz | tar xzv
$ sudo cp linux-amd64/helm /usr/local/bin
$ rm -rf linux-amd64

# Mac 用户
$ brew install helm
```

### 使用

- [Artifact Hub](https://artifacthub.io/)

```bash


# 添加 charts repo
$ helm repo add bitnami https://charts.bitnami.com/bitnami

# 测试安装 redis chart
$ helm install my-redis bitnami/redis

# 删除 redis
$ helm uninstall my-redis
```

## [NGINX Ingress](https://github.com/kubernetes/ingress-nginx/tree/master/charts/ingress-nginx)

```bash
# install by helm
$ helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
$ helm repo update

$ helm install ingress-nginx ingress-nginx/ingress-nginx
```

## [Istio](https://istio.io/)

### [下载并安装 Istio](https://istio.io/docs/setup/getting-started/)

```bash
$ curl -L https://istio.io/downloadIstio | sh -
# 进入下载的文件夹，这里以 `istio-1.9.0` 为例
$ cd istio-1.11.4
$ export PATH=$PWD/bin:$PATH
# 安装
$ istioctl install --set profile=demo -y
# 设置自动注入 Envoy sidecar proxies
$ kubectl label namespace default istio-injection=enabled
```

### 部署示例

```bash
# 部署
$ kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
# 查看示例返回
$ kubectl exec -it $(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"
```

## 升级 Kubernetes 版本

```bash
# 修改 `init.yml` 中 `kubernetesVersion` 版本号， 执行
sudo kubeadm upgrade apply --config init.yml --ignore-preflight-errors=SystemVerification
```
