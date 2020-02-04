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

ingress: accounting: spec: rules: [{
	host: "accounting.\(HOST)"
	http: paths: [{
		path: "/accounting"
		backend: {
			serviceName: "accounting"
			servicePort: "http"
		}
	}]
}]
