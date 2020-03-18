package lube

job: terraform_destroy: spec: template: spec: {
	containers: [
		{
			command: ["sh", "/terraform/destroy.sh"]
		}
	]
}
