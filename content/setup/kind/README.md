# kind

- [kubernetes-sigs/kind](https://github.com/kubernetes-sigs/kind)

```bash
curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/v0.8.0/kind-darwin-amd64
chmod +x ./kind
sudo mv ./kind /user/local/bin/kind

# 创建集群
kind create cluster --config config.yaml

# 使用
kubectl config use-context kind-kind
kubectl get pod -A

#删除集群
kind delete cluster
```
