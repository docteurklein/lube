# lube

Less painful **L**ocal K**ube**rnetes with cue-lang.

## dependencies

- https://github.com/kubernetes-sigs/kind
- https://kubernetes.io/docs/tasks/tools/install-kubectl
- https://github.com/cuelang/cue
- https://github.com/rancher/local-path-provisioner


## setup local k8s cluster (once)

```
kind create cluster --config cluster.yaml
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml


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
