package lube

ingress: nginx: spec: rules: [{
	host: string | *"nginx.dev.cloud.akeneo.com"
}]

deployment: nginx: spec: template: spec: containers: [...{
	resources: {
		requests: {
			memory: string | *"64Mi"
			cpu:    string | *"250m"
		}
		limits: {
			memory: string | *"128Mi"
			cpu:    string | *"500m"
		}
	}
}]
