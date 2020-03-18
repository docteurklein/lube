package lube

job: terraform_apply: spec: template: spec: {
	containers: [
		{
			command: ["sh", "/terraform/apply.sh"]
			env: [{ name: "NS", value: "\(NS)" }]
		}
	]
}
