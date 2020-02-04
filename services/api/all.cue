package lube

http_port: {
	name: "http"
	port: 80
}

service: api: spec: ports: [http_port]

deployment: api: spec: template: spec: containers: [
	{
		name:  "api"
		image: "registry.localhost:5000/api:latest"
		ports: [{
			name:          http_port.name
			containerPort: http_port.port
		}]
	},
]

ingress: api: spec: rules: [{
	host: "api.\(HOST)"
	http: paths: [{
		path: "/api"
		backend: {
			serviceName: "api"
			servicePort: http_port.name
		}
	}]
}]
