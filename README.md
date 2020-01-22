# lube

Less painful **L**ocal K**ube**rnetes with cue-lang.

## dependencies

- https://github.com/kubernetes-sigs/kind (0.7+)
- https://github.com/cuelang/cue (0.0.14+)
- https://kubernetes.io/docs/tasks/tools/install-kubectl


## setup local k8s cluster (once)

```
kind create cluster --config cluster.yaml


export NS="$(basename $PWD)"
kubectl create ns "$NS"
kubectl config set-context --current --namespace="$NS"

cat > local.cue <<-EOF
package lube

PWD: "/host${PWD}" // see cluster.yaml
EOF
```

## deploy

```
cue yaml ./services/dev/local

cue up ./services/dev/local

# down
kubectl delete ns "$NS"
```


## forward locally to a random port

```
kubectl port-forward "$(kubectl get pod -o 'jsonpath={.items[0].metadata.name}' -l 'name=nginx')" 0:80
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
