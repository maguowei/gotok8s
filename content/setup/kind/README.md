# kind

- [kubernetes-sigs/kind](https://github.com/kubernetes-sigs/kind)

```bash
curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/v0.5.1/kind-darwin-amd64
chmod +x ./kind
mv ./kind /user/local/bin/kind

# 创建集群
kind create cluster --config config.yaml

# 使用
export KUBECONFIG="$(kind get kubeconfig-path --name="kind")"
kubectl get pod -A

#删除集群
kind delete cluster
```
