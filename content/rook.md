# [Rook](https://github.com/rook/rook)

```bash
# 部署 Rook Operator
$ kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/crds.yaml
$ kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/common.yaml
$ kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/operator.yaml

# 创建 Rook Ceph Cluster
# for test environment only a single worker node is required
$ kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/cluster-test.yaml
# or for production need least three worker nodes.
$ kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/cluster.yaml

# 列出 rook-ceph 命名空间下的 pods
$ kubectl -n rook-ceph get pod

# 创建块存储(block storage)
# for test
$ kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/csi/rbd/storageclass-test.yaml
# or for production
$ kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/csi/rbd/storageclass.yaml

# 将 rook-block 设置为默认的 storageclass 
$ kubectl patch storageclass rook-ceph-block -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

```bash
# Shared File System

# Create the File System
# for test
kubectl create -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/filesystem-test.yaml
# or for production
kubectl create -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/filesystem.yaml

# Create StorageClass
kubectl create -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/csi/cephfs/storageclass.yaml

# 启动rook-ceph-tools pod
kubectl create -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/toolbox.yaml
# 进入 pod
kubectl -n rook-ceph exec -it rook-ceph-tools bash

# Start the Direct Mount Pod
kubectl apply -f https://raw.githubusercontent.com/rook/rook/release-1.6/cluster/examples/kubernetes/ceph/direct-mount.yaml

# Create the directory
mkdir /tmp/registry

# Detect the mon endpoints and the user secret for the connection
mon_endpoints=$(grep mon_host /etc/ceph/ceph.conf | awk '{print $3}')
my_secret=$(grep key /etc/ceph/keyring | awk '{print $3}')

# Mount the filesystem
mount -t ceph -o mds_namespace=myfs,name=admin,secret=$my_secret $mon_endpoints:/ /tmp/registry

# See your mounted filesystem
df -h

# Unmount the Filesystem
umount /tmp/registry
rmdir /tmp/registry
```

```bash
# Object Storage

# Create an Object Store
kubectl create -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/object.yaml

# To confirm the object store is configured, wait for the rgw pod to start
kubectl -n rook-ceph get pod -l app=rook-ceph-rgw

# Create a User
kubectl create -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/object-user.yaml

# To confirm the object store user is configured, describe the secret
kubectl -n rook-ceph describe secret rook-ceph-object-user-my-store-my-user

# To directly retrieve the secrets:
kubectl -n rook-ceph get secret rook-ceph-object-user-my-store-my-user -o yaml | grep AccessKey | awk '{print $2}' | base64 --decode
kubectl -n rook-ceph get secret rook-ceph-object-user-my-store-my-user -o yaml | grep SecretKey | awk '{print $2}' | base64 --decode

# Access External to the Cluster
kubectl create -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/rgw-external.yaml

# See both rgw services running and notice what port the external service is running on:
kubectl -n rook-ceph get service rook-ceph-rgw-my-store rook-ceph-rgw-my-store-external

# Consume the Object Storage
export AWS_ENDPOINT=10.104.35.31:80
export AWS_ACCESS_KEY_ID=XEZDB3UJ6X7HVBE7X7MA
export AWS_SECRET_ACCESS_KEY=7yGIZON7EhFORz0I40BFniML36D2rl8CQQ5kXU6l
```
