package kube

http_port :: "http"

service: api: spec: ports: [{
	name: http_port
	port: 80
}]

deployment: api: spec: template: spec: {
	containers: [
		{
			name:  "nginx"
			image: "nginx:alpine"
			ports: [{
				name:          http_port
				containerPort: 80
			}]
			volumeMounts: [{
				mountPath: "/home/florian/work/docteurklein/lube"
				name: "sources"
			}]
		},
	]
	volumes: [{
		name: "sources"
		hostPath: {
			path: "/home/florian/work/docteurklein/lube"
			type: "Directory"
		}
	}]
}
