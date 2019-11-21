package lube

ingress: nginx: spec: rules: [{
	host: "nginx.prod.localhost"
}]

deployment: nginx: spec: replicas: 4

deployment: nginx: spec: template: spec: containers: [...{
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
