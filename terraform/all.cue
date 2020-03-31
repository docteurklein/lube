package lube

job: terraform: spec: template: spec: {
	containers: [
		{
			name:  "terraform"
			image: "hashicorp/terraform"
			workingDir: "/tfstate"
			command: ["sh", "-c", "terraform init /terraform && terraform plan /terraform && terraform apply -auto-approve /terraform"]
			volumeMounts: [
				{
					name: "tfstate"
					mountPath: "/tfstate"
				},
				{
					name: "terraform"
					mountPath: "/terraform"
				},
			]
		}
	]
	volumes: [
		{
			name: "tfstate"
			persistentVolumeClaim: {
				claimName: "tfstate"
			}
		},
		{
			name: "terraform"
			configMap: {
				name: "terraform"
			}
		},
	]
}

pvc: tfstate: spec: {
	storageClassName: "local-path"
	resources: requests: storage: "50Mi"
}
