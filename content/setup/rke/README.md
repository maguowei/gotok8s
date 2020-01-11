# RKE

## Install Rancher

```bash
$ docker run --name rancher -d --restart=unless-stopped \
  -p 8080:80 -p 8443:443 \
  -v rancher:/var/lib/rancher \
  rancher/rancher:latest
```

## Install RKE

- [rancher/rke releases](https://github.com/rancher/rke/releases)

```bash
# add .ssh/id_rsa.pub to server .ssh/authorized_keys
$ curl -Lo ./rke https://github.com/rancher/rke/releases/download/v1.0.0/rke_linux-amd64
$ chmod +x ./rke
$ sudo mv ./rke /usr/local/bin/rke

$ rke up
$ rke remove
```

## Ref

- [RKE Kubernetes Installation](https://rancher.com/docs/rke/latest/en/installation/)
- [Rancher 中文文档](https://docs.rancher.cn/)
