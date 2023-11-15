# ingress-nginx lua scripts

```bash
kubectl create namespace ingress-nginx

kubectl apply -f ingress-nginx/custom/lua/lua-scripts-configmap.yaml

helm install -n ingress-nginx ingress-nginx ingress-nginx/ingress-nginx -f ingress-nginx/custom/lua/values.yaml

kubectl apply -f ingress-nginx/custom/lua/ingress.yaml
```