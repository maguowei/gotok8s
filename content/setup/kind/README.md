# kind

- [kubernetes-sigs/kind](https://github.com/kubernetes-sigs/kind)

```bash
brew install kind

# 创建集群
kind create cluster --config config.yaml

# 使用
kubectl config use-context kind-kind
kubectl get pod -A

#删除集群
kind delete cluster
```
