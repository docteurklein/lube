package kube

objects: [ x for v in objectSets for x in v ]

objectSets: [
	deployment,
	service,
]
