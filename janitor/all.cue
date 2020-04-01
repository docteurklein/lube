package lube

deployment: janitor: spec: template: spec: {
	serviceAccountName: "kube-janitor"
	containers: [
		{
			name:  "janitor"
			image: "hjacobs/kube-janitor:20.3.2"
			args: ["--debug"]
			securityContext: {
				readOnlyRootFilesystem: true
				runAsNonRoot:           true
				runAsUser:              1000
			}
		},
	]
}
deployment: janitor: _with_service: false
