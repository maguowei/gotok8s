# Goto Kubernetes

[![github workflow](https://github.com/gotok8s/gotok8s/workflows/k8s%20image%20sync/badge.svg)](https://github.com/gotok8s/gotok8s/actions)

## 安装 `Kubernetes`

- [kind](content/setup/kind/README.md)
- [k3d](content/setup/k3d/README.md)
- [k3s](content/setup/k3s/README.md)
- [rke](content/setup/rke/README.md)

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
# 进入下载的文件夹，这里以 `istio-1.18.1` 为例
$ cd istio-1.18.1
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
