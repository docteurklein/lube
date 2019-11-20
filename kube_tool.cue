package kube

import (
	_yaml "encoding/yaml"
	_json "encoding/json"
	"tool/cli"
)

objects: [ x for v in [deployment, service] for x in v ]

command: yaml: task: print: cli.Print & {
	text: _yaml.MarshalStream(objects)
}

command: json: task: print: cli.Print & {
	text: _json.MarshalStream(objects)
}

command: up: task: kube: exec.Run & {
	cmd:   "kubectl apply -f -"
	stdin: yaml.MarshalStream(objects)
}
