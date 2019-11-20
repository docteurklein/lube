# lube

Less painful **L**ocal K**ube**rnetes with cue-lang.

## dependencies

- https://github.com/kubernetes-sigs/kind
- https://github.com/cuelang/cue
- https://golang.org

## setup local k8s cluster (once)

	kind create cluster --config cluster.yaml


## setup cue (once)

	xargs -P0 -L1 -n1 -I{} sh -c 'go get k8s.io/api/{} && cue get go k8s.io/api/{}' <<-EOF
		core/v1
		apps/v1
		extensions/v1beta1
	EOF


## deploy

	cue yaml ./...
	cue up ./...


## forward locally to a random port

	kubectl port-forward "$(kubectl get pod -o 'jsonpath={.items[0].metadata.name}' -l 'name=api')" 0:80
