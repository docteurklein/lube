package lube

ingress: nginx: spec: rules: [{
	host: "nginx.dev.localhost"
}]

PWD: string

deployment: nginx: spec: template: spec: {
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
			path: PWD
			type: "Directory"
		}
	}]
}
