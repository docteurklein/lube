package lube

command: """
    system:"echo 'HTTP/1.0 200 OK'; echo 'Content-type: application/json'; echo; echo '{"finalized": true}'"
    """

deployment: "terraform-destroy": spec: template: spec: containers: [
	{
		name:  "terraform-destroy-hook"
		image: "alpine/socat:latest"
        args: ["-v", "tcp-listen:80,reuseaddr,fork", command]
		ports: [{
			name:          "http"
			containerPort: 80
		}]
	},
]
