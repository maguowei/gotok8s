# nginx-ingress

```bash
# run example
$ kubectl run my-nginx --image=nginx --port=80 --expose=true
$ kubectl apply -f example-ingress.yaml

# now you can visit http://test.example.com
$ curl -D- http://localhost -H 'Host: test.example.com'

# cleanup
$ kubectl delete service my-nginx
$ kubectl delete pod my-nginx
$ kubectl delete -f example-ingress.yaml
```

## Refs

- [kubernetes/ingress-nginx](https://github.com/kubernetes/ingress-nginx)
