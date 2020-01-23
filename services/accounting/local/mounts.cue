package lube

PWD: string

deployment: accounting: spec: template: spec: {
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
				path: "\(PWD)/accounting"
				type: "Directory"
			}
		}
	]
}
