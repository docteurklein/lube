# lube

Less painful **L**ocal K**ube**rnetes with cue-lang.

## dependencies

- https://github.com/cuelang/cue/tree/0846b9324399ff782fcc38e0c156f418910b361c
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
kubectl create configmap terraform --from-file terraform || \
kubectl create configmap terraform --from-file terraform -o yaml --dry-run | kubectl replace -f -

cue -t NS=$NS -t PWD=$PWD yaml ./services/*/local
cue -t vhost=test.example.org -t NS=$NS -t PWD=$PWD apply ./services/*/local ./terraform

curl -isSL 0/accounting -H 'Host: accounting.test.example.org'
```

## delete

```
kubectl delete ns "$NS"
```

## auto cleanup

```
kubectl apply -n janitor -f janitor/rbac.yaml
cue -t NS=janitor apply ./janitor

kubectl annotate ns "$NS" janitor/ttl=1h
```


## terraform controller

```
kubectl create namespace metacontroller
kubectl -n metacontroller apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/metacontroller/master/manifests/metacontroller-rbac.yaml
kubectl -n metacontroller apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/metacontroller/master/manifests/metacontroller.yaml
```


## download latest kubernetes definitions

> Note: This might break stuff.

```
xargs -P0 -L1 -n1 -I{} sh -c 'go get {} && cue get go {}' <<-EOF
   k8s.io/api/core/v1
   k8s.io/api/apps/v1
   k8s.io/api/batch/v1
   k8s.io/api/apps/v1beta1
   k8s.io/api/extensions/v1beta1
EOF
```
