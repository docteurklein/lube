package lube

deployment: api: metadata: annotations: "janitor/ttl": TTL
deployment: api: spec: template: spec: containers: [
	{
		name:  "api"
		image: "registry.localhost:5000/api:latest"
	},
]

deployment: api: _with_service: false
