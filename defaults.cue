package lube

import (
	v1 "k8s.io/api/core/v1"
	apps_v1 "k8s.io/api/apps/v1beta1"
	extensions_v1beta1 "k8s.io/api/extensions/v1beta1"
)

service: [string]:    v1.Service
deployment: [string]: apps_v1.Deployment
ingress: [string]:    extensions_v1beta1.Ingress

deployment: [ID=_]: _spec & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: ID
	spec: {
		selector: matchLabels: name: ID
		replicas: *1 | int
		template: {
			metadata: labels: name: ID
			spec: containers: [...{
				ports: [...{containerPort: >0 & <=65365}]
				resources: {
					requests: {
						memory: string | *"64Mi"
						cpu:    string | *"250m"
					}
					limits: {
						memory: string | *"128Mi"
						cpu:    string | *"500m"
					}
				}
			}]
		}
	}
	_with_service: bool | *true
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
		}]
		selector: metadata.labels
	}
	_with_ingress: bool | *false
}

ingress: [ID=_]: {
	apiVersion: "networking.k8s.io/v1beta1"
	kind:       "Ingress"
	metadata: {
		name: ID
		annotations: "kubernetes.io/ingress.class": "traefik"
	}
}

_spec: spec: template: spec: containers: [...{
	ports: [...{
		_export: *true | false // include the port in the service
	}]
}]

for x in [deployment] for ID, deployment in x if deployment._with_service {
	service: "\(ID)": {
		spec: selector: deployment.spec.template.metadata.labels

		spec: ports: [ {
			Port = p.containerPort // Port is an alias
			port:       *Port | int
			targetPort: *Port | int
		} for c in deployment.spec.template.spec.containers
			for p in c.ports
			if p._export ]
	}
}

for x in [service] for ID, service in x if service._with_ingress {
	ingress: "\(ID)": spec: rules: [{
		host: "\(ID).\(HOST)"
		http: paths: [{
			path: "/\(ID)"
			backend: {
				serviceName: service.metadata.name
				servicePort: "http"
			}
		}]
	}]
}
