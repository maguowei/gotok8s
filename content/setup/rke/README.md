# RKE

## Install Rancher

```bash
# run rancher
$ docker run --name rancher --privileged -d --restart=unless-stopped -p 8080:80 -p 8443:443 -v rancher:/var/lib/rancher rancher/rancher
```

## Install RKE

- [rancher/rke releases](https://github.com/rancher/rke/releases)

```bash
# add .ssh/id_rsa.pub to server .ssh/authorized_keys
$ curl -Lo ./rke https://github.com/rancher/rke/releases/download/v1.3.8/rke_linux-amd64
$ chmod +x ./rke
$ sudo mv ./rke /usr/local/bin/rke
```

## Install Docker on Node

```bash
$ curl -fsSL https://get.docker.com/ | sh
$ sudo usermod -aG docker $USER
```

## Up and Down

```bash
# Bring the cluster up
$ rke up

# Teardown the cluster and clean cluster nodes
$ rke remove
```

## Ref

- [RKE Kubernetes Installation](https://rancher.com/docs/rke/latest/en/installation/)
- [Rancher 中文文档](https://docs.rancher.cn/)
