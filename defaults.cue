package kube

import (
	v1 "k8s.io/api/core/v1"
	apps_v1 "k8s.io/api/apps/v1"
	extensions_v1beta1 "k8s.io/api/extensions/v1beta1"
)

service: [string]:    v1.Service
deployment: [string]: apps_v1.Deployment
ingress: [string]:    extensions_v1beta1.Ingress

deployment: [ID=_]: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: ID
	spec: {
		selector: matchLabels: name: ID
		// 1 is the default, but we allow any number
		replicas: *1 | int
		template: {
			metadata: labels: name: ID
			spec: containers: [...{
				ports: [...{containerPort: >0 & <=65365}]
			}]
		}
	}
}

service: [ID=_]: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: ID
		labels: name: ID
	}
	spec: {
		ports: [...{
			port:     >0 & <=65365
			protocol: *"TCP" | "UDP"
			name:     string
		}]
		selector: metadata.labels
	}
}

ingress: [ID=_]: {
	apiVersion: "networking.k8s.io/v1beta1"
	kind:       "Ingress"
	metadata: {
		name: ID
		annotations: "kubernetes.io/ingress.class": "nginx"
	}
}
