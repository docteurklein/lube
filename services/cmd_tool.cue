package kube

import (
	"encoding/yaml"
	"tool/cli"
)

objects: [ x for v in objectSets for x in v ]

objectSets: [
	deployment,
	service,
]

command: dump: task: print: cli.Print & {
	text: yaml.MarshalStream(objects)
}

command: up: {
	task: kube: exec.Run & {
		cmd:    "kubectl apply -f -"
		stdin:  yaml.MarshalStream(objects)
	}
}
