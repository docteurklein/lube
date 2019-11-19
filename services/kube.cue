package kube

deployment: [ID=_]: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: ID
	spec: {
		selector: matchLabels: name: ID
		// 1 is the default, but we allow any number
		replicas: *1 | int
		template: {
			metadata: labels: {
				name:   ID
				domain: "prod"
			}
			spec: containers: [...{
				ports: [...{containerPort: >0 & <=65365}]
			}]
		}
	}
}

service: [ID=_]: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: ID
		labels: {
			name:    ID     // by convention
		}
	}
	spec: {
		ports: [...{
			port:     >0 & <=65365
			protocol: *"TCP" | "UDP" // from the Kubernetes definition
			name:     string
		}]
		selector: metadata.labels // we want those to be the same
	}
}
