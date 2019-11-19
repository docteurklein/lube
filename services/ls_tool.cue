package kube

import (
	"text/tabwriter"
	"tool/cli"
)

command: ls: task: print: cli.Print & {
	text: tabwriter.Write([
		"\(x.kind)  \t\(x.metadata.name)"
		for x in objects
	])
}
