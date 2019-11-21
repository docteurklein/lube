package lube

ingress: api: spec: rules: [{
	host: "api.prod.localhost"
}]

deployment: api: spec: replicas: 4

deployment: api: spec: template: spec: containers: [...{
	resources: {
		requests: {
			memory: "128Mi"
			cpu:    "1"
		}
		limits: {
			memory: "1Gi"
			cpu:    "4"
		}
	}
}]
