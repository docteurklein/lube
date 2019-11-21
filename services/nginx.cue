package lube

http_port: {
	name: "http"
	port: 80
}

service: nginx: spec: ports: [http_port]

deployment: nginx: spec: template: spec: containers: [
	{
		name:  "nginx"
		image: "nginx:alpine"
		ports: [{
			name:          http_port.name
			containerPort: http_port.port
		}]
	},
]

ingress: nginx: spec: rules: [{
	host: string
	http: paths: [{
		path: "/"
		backend: {
			serviceName: "nginx"
			servicePort: http_port.name
		}
	}]
}]
