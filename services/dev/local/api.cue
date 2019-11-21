package lube

ingress: api: spec: rules: [{
	host: "api.dev.localhost"
}]

PWD: string

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
			path: PWD
			type: "Directory"
		}
	}]
}
