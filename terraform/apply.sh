set -exuo pipefail

terraform init /terraform
terraform apply -auto-approve -lock=false /terraform

kubectl create -n "$NS" configmap terraform --from-file /terraform -o yaml --dry-run | kubectl replace -f -
