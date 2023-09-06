# Goto Kubernetes

[![github workflow](https://github.com/gotok8s/gotok8s/workflows/k8s%20image%20sync/badge.svg)](https://github.com/gotok8s/gotok8s/actions)

## 安装 `Kubernetes`

- [kind](content/setup/kind/README.md)
- [k3d](content/setup/k3d/README.md)
- [k3s](content/setup/k3s/README.md)
- [rke](content/setup/rke/README.md)

## [Helm](https://github.com/kubernetes/helm)

### 安装

详细使用说明请参考 [`Helm`官方文档](https://v3.helm.sh/docs/)

```bash
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

## [Kubernetes Dashboard](https://github.com/kubernetes/dashboard)

### 部署 Kubernetes Dashboard

```bash
$ helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
$ helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
```

### 创建`Dashboard`管理员用户并用`token`登陆

- [Creating sample user](https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md)

```bash
# 创建 ServiceAccount admin-user 并绑定集群管理员权限
$ kubectl apply -f https://raw.githubusercontent.com/gotok8s/gotok8s/master/dashboard-adminuser.yaml

# 获取登陆 token
$ kubectl get secret admin-user -n kubernetes-dashboard -o jsonpath={".data.token"} | base64 -d
```

### 访问Dashboard

```bash
$ kubectl -n kubernetes-dashboard port-forward service/kubernetes-dashboard 8443:443
```
通过下面的连接访问 Dashboard: [https://127.0.0.1:8443/](https://127.0.0.1:8443/)

输入上一步获取的token, 验证并登陆。


## [NGINX Ingress](https://github.com/kubernetes/ingress-nginx/tree/master/charts/ingress-nginx)

```bash
# install by helm
$ helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
$ helm repo update

$ helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace
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
