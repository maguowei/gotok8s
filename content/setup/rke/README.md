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
$ brew install rke
$ rke up
$ rke remove
```
