# kind

- [kubernetes-sigs/kind](https://github.com/kubernetes-sigs/kind)

```bash
curl -Lo ./kind-darwin-amd64 https://github.com/kubernetes-sigs/kind/releases/download/v0.4.0/kind-darwin-amd64
chmod +x ./kind-darwin-amd64
mv ./kind-darwin-amd64 /user/local/bin/kind

# 创建集群
kind create cluster --config config.yaml

# 使用
export KUBECONFIG="$(kind get kubeconfig-path --name="kind")"
kubectl get pod -A

#删除集群
kind delete cluster
```
