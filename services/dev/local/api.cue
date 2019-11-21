package kube

ingress: api: spec: rules: [{
	host: "api.dev.localhost"
}]

deployment: api: spec: template: spec: {
	containers: [
		{
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
