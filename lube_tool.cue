package lube

import (
	_yaml "encoding/yaml"
	_json "encoding/json"
	"tool/cli"
	"tool/exec"
)

objects: [ x for v in [deployment, service, ingress, job, configMap] for x in v ]

command: yaml: task: print: cli.Print & {
	text: _yaml.MarshalStream(objects)
}

command: json: task: print: cli.Print & {
	text: _json.MarshalStream(objects)
}

command: apply: task: kube: exec.Run & {
	cmd:   "kubectl apply -f -"
	stdin: _yaml.MarshalStream(objects)
}
