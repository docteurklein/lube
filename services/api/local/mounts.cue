package lube

PWD: string

deployment: api: spec: template: spec: {
	containers: [
		{
			volumeMounts: [
				{
					name:      "sources"
					mountPath: "/usr/src/app"
				}
			]
		}
	]
	volumes: [
		{
			name: "sources"
			hostPath: {
				path: "\(PWD)/api"
				type: "Directory"
			}
		}
	]
}
