package lube

ingress: api: spec: rules: [{
	host: string | *"api.dev.cloud.akeneo.com"
}]

deployment: api: spec: template: spec: containers: [...{
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
