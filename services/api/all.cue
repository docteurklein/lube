package lube

http_port: {
	name: "http"
	port: 80
}

service: api: spec: ports: [http_port]

deployment: api: spec: template: spec: containers: [
	{
		name:  "api"
		image: "api:test2"
		ports: [{
			name:          http_port.name
			containerPort: http_port.port
		}]
	},
]

ingress: api: spec: rules: [{
	host: HOST
	http: paths: [{
		path: "/api"
		backend: {
			serviceName: "api"
			servicePort: http_port.name
		}
	}]
}]
