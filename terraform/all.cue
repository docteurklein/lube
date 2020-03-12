package lube

job: terraform: spec: template: spec: {
	containers: [
		{
			name:  "terraform"
			image: "hashicorp/terraform"
			command: ["sh", "/terraform/tfcommand.sh"]
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
