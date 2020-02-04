package lube

deployment: api: spec: template: spec: containers: [
	{
		name:  "api"
		image: "registry.localhost:5000/api:latest"
	},
]

deployment: api: _with_service: false
