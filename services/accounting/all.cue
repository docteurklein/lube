package lube

deployment: accounting: spec: template: spec: containers: [
	{
		name:  "accounting"
		image: "registry.localhost:5000/accounting:latest"
	},
	{
		name:  "nginx"
		image: "nginx:latest"
		ports: [{
			name:          "http"
			containerPort: 80
		}]
	},
]

service: accounting: _with_ingress: true
