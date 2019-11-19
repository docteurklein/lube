# lube

**L**ocal **K**ubernetes with cue-lang.

## dependencies

	- https://github.com/talos-systems/talos
	- https://github.com/cuelang/cue

## setup local k8s cluster

	osctl cluster create
	# wait
	osctl kubeconfig > kubeconfig

	export KUBECONFIG=$(realpath kubeconfig)

	# test it works
	kubectl get all --all-namespaces


## setup cue

	go get k8s.io/api/apps/v1
	go get k8s.io/api/extensions/v1beta1
	go get k8s.io/api/apps/v1beta1

	cue get k8s.io/api/apps/v1
	cue get k8s.io/api/extensions/v1beta1
	cue get k8s.io/api/apps/v1beta1


## deploy

	cue dump ./... | kubectl apply -f -


## forward locally to a random port

	kubectl port-forward "$(kubectl get pod -o 'jsonpath={.items[0].metadata.name}' -l 'name=api')" 0:80

