# RKE2

## Install RKE2

- [rancher/rke2](https://github.com/rancher/rke2)

```bash
$ curl -sfL https://get.rke2.io | sh -
$ systemctl enable rke2-server.service
$ systemctl start rke2-server.service
# Wait a bit
$ export KUBECONFIG=/etc/rancher/rke2/rke2.yaml PATH=$PATH:/var/lib/rancher/rke2/bin
$ kubectl get nodes
```

## Install Rancher

```bash
# run rancher
$ docker run --name rancher --privileged -d --restart=unless-stopped -p 8080:80 -p 8443:443 -v rancher:/var/lib/rancher rancher/rancher
```

## Ref

- [RKE2 Docs](https://docs.rke2.io/)
