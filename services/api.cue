package kube

http_port: {
	name: "http"
	port: 80
}

service: api: spec: ports: [http_port]

deployment: api: spec: template: spec: {
	containers: [
		{
			name:  "nginx"
			image: "nginx:alpine"
			ports: [{
				name:          http_port.name
				containerPort: http_port.port
			}]
			volumeMounts: [{
				mountPath: "/usr/share/nginx/html"
				name:      "sources"
			}]
		},
	]
	volumes: [{
		name: "sources"
		hostPath: {
			path: "/host/florian/work/docteurklein/lube"
			type: "Directory"
		}
	}]
}

ingress: api: spec: rules: [{
	host: string | *"api.default.localhost"
	http: paths: [{
		path: "/"
		backend: {
			serviceName: "api"
			servicePort: http_port.name
		}
	}]
}]
