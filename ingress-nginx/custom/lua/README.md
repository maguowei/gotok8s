# ingress-nginx lua scripts

```bash
kubectl create namespace ingress-nginx

kubectl apply -f ingress-nginx/custom/lua/lua-scripts-configmap.yaml

helm install -n ingress-nginx ingress-nginx ingress-nginx/ingress-nginx -f ingress-nginx/custom/lua/values.yaml

kubectl apply -f ingress-nginx/custom/lua/ingress.yaml


# ingrss 升级
helm upgrade -n ingress-nginx ingress-nginx ingress-nginx/ingress-nginx -f ingress-nginx/custom/lua/values.yaml

# 删除ingress
helm delete -n ingress-nginx ingress-nginx
```

## 依赖部署

```bash
# jaeger https://www.jaegertracing.io/docs/1.51/getting-started/

docker run --rm -d --name jaeger -p 16686:16686 -p 4317:4317 -p 4318:4318 jaegertracing/all-in-one:1.51
```
