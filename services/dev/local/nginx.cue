package lube

ingress: nginx: spec: rules: [{
	host: "nginx.dev.localhost"
}]

PWD: string

deployment: nginx: spec: template: spec: {
	containers: [
		{
			volumeMounts: [
				{
					name:      "sources"
					mountPath: "/usr/share/nginx/html"
				},
				{
					name:      "nginx-pvc-1"
					mountPath: "/nginx-pvc-1"
				},
				{
					name:      "nginx-pvc-2"
					mountPath: "/nginx-pvc-2"
				},
			]
		},
	]
	volumes: [
		{
			name: "sources"
			hostPath: {
				path: PWD
				type: "Directory"
			}
		},
		{
			name: "nginx-pvc-1"
			persistentVolumeClaim: claimName: "nginx-pvc-1"
		},
		{
			name: "nginx-pvc-2"
			persistentVolumeClaim: claimName: "nginx-pvc-2"
		},
	]
}
