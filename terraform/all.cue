package lube

job: [ID=_]: spec: template: spec: {
	containers: [
		{
			name:  "terraform"
			image: "hashicorp/terraform"
			volumeMounts: [
				{
					name: "terraform"
					mountPath: "/terraform"
				},
			]
		}
	]
	volumes: [
		{
			name: "terraform"
			configMap: {
				name: "terraform"
			}
		},
	]
}
