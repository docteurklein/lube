package lube

http_port: {
	name: "http"
	port: 80
}

service: accounting: spec: ports: [http_port]

deployment: accounting: spec: template: spec: containers: [
	{
		name:  "accounting"
		image: "registry.localhost:5000/accounting:latest"
	},
	{
		name:  "nginx"
		image: "nginx:latest"
		ports: [{
			name:          http_port.name
			containerPort: http_port.port
		}]
	},
]

ingress: accounting: spec: rules: [{
	host: "accounting.\(HOST)"
	http: paths: [{
		path: "/accounting"
		backend: {
			serviceName: "accounting"
			servicePort: http_port.name
		}
	}]
}]
