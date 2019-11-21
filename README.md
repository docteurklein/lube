# lube

Less painful **L**ocal K**ube**rnetes with cue-lang.

## dependencies

- https://github.com/kubernetes-sigs/kind
- https://kubernetes.io/docs/tasks/tools/install-kubectl
- https://github.com/cuelang/cue

## setup local k8s cluster (once)

```
kind create cluster --config cluster.yaml
kubectl create ns test
kubectl config set-context --current --namespace=test

cat > local.cue <<-EOF
package lube

PWD: "/host${PWD}" // see cluster.yaml
EOF
```

## deploy

```
cue yaml ./services/dev/local

cue up ./services/dev/local # or prod

# down
kubectl delete ns test
```


## forward locally to a random port

```
kubectl port-forward "$(kubectl get pod -o 'jsonpath={.items[0].metadata.name}' -l 'name=api')" 0:80
```
