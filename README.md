# lube

Less painful **L**ocal K**ube**rnetes with cue-lang.

## dependencies

- https://github.com/cuelang/cue (0.0.14+)
- https://github.com/rancher/k3d
- https://kubernetes.io/docs/tasks/tools/install-kubectl


## setup local k8s cluster (once)

```
k3d create --volume $HOME:$HOME --enable-registry --registry-name=registry.localhost --publish 80:80
export KUBECONFIG="$(k3d get-kubeconfig --name='k3s-default')"

export NS="$(basename $PWD)"
kubectl create ns "$NS"
kubectl config set-context --current --namespace="$NS"
```


## deploy

```
cat > local.cue <<-EOF
package lube

PWD: "$PWD"
HOST: "test.example.org"
EOF
```

```
cue yaml ./services/{api,accounting}/local
cue up ./services/{api,accounting}/local

curl -isSL 0/accounting -H 'Host: accounting.test.example.org'
```


## download latest kubernetes definitions

> Note: This might break stuff.

```
xargs -P0 -L1 -n1 -I{} sh -c 'go get {} && cue get go {}' <<-EOF
   k8s.io/api/core/v1
   k8s.io/api/apps/v1
   k8s.io/api/apps/v1beta1
   k8s.io/api/extensions/v1beta1
EOF
```
