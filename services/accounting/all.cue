package lube

http_port: {
	name: "http"
	port: 80
}

service: accounting: spec: ports: [http_port]

deployment: accounting: spec: template: spec: containers: [
	{
		name:  "accounting"
		image: "accounting:test2"
		ports: [{
			name:          http_port.name
			containerPort: http_port.port
		}]
	},
]

ingress: accounting: spec: rules: [{
	host: HOST
	http: paths: [{
		path: "/accounting"
		backend: {
			serviceName: "accounting"
			servicePort: http_port.name
		}
	}]
}]
