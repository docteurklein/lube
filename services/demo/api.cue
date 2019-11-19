package kube

service: api: spec: ports: [{
	name: "http"
	port: 80
}]

deployment: api: spec: template: spec: containers: [
	{
		name:  "nginx"
		image: "nginx:alpine"
		ports: [{
			name:          "http"
			containerPort: 80
		}]
	},
]
