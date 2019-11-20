# lube

Less painful **L**ocal K**ube**rnetes with cue-lang.

## dependencies

- https://github.com/talos-systems/talos
- https://github.com/cuelang/cue
- https://golang.org

## setup local k8s cluster

	osctl cluster create
	# wait
	osctl kubeconfig > kubeconfig

	export KUBECONFIG=$(realpath kubeconfig)

	# test it works
	kubectl get all --all-namespaces


## setup cue

	xargs -P0 -L1 -n1 -I{} sh -c 'go get k8s.io/api/{} && cue get go k8s.io/api/{}' <<-EOF
		apps/v1
		extensions/v1beta1
		apps/v1beta1
	EOF


## deploy

	cue up ./...


## forward locally to a random port

	kubectl port-forward "$(kubectl get pod -o 'jsonpath={.items[0].metadata.name}' -l 'name=api')" 0:80

